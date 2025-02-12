% +------------------------------------------------------+
% |      Wind Rose plot with MATLAB Implementation       | 
% |                                                      |
% | Author: Ph.D. Eng. Hristo Zhivomirov        05/12/24 | 
% +------------------------------------------------------+
%% https://www.mathworks.com/matlabcentral/fileexchange/167981-wind-rose-with-matlab
% function: windrose = windrose(winddir, windspeed)
%
% Input:
% winddir - direction from which the wind originates, cardinal or deg; 
% windspeed - speed of the wind, m/s.
% 
% Output: 
% windrose - 16-by-7 matrix, containing frequencies of occurrence
%            for each wind direction (column-wise) and speed (row-wise).
%            If the function is called without output arguments then only 
%            the Wind Rose plot is visualized.
%
% Note: The plot uses 16 spatial directions (N, NNE, NE, ENE, E, etc.)  
% and 7 speed levels (0 to 4 m/s, 4 to 8 m/s, etc.) coded with colors.
function windroseZhivomirov = windroseZhivomirov(winddir, windspeed)
                  
% convert the wind direction from cardinal to deg
if iscell(winddir), winddir = cardinal2deg(winddir); end
% convert the wind direction from deg to rad   
winddir = deg2rad(winddir);
 
% input validation
validateattributes(winddir, {'single', 'double'}, ...
                            {'vector', 'real', 'nonnan', 'nonempty', 'finite'}, ...
                             '', 'winddir', 1)
validateattributes(windspeed, {'single', 'double'}, ...
                              {'vector', 'real', 'nonnan', 'nonempty', 'finite'}, ...
                               '', 'windspeed', 2)
                           
% prepare the wind direction and wind speed bins edges
directedges = deg2rad([0, 11.25:22.5:348.75, 360]);
speededges = [0:4:24 Inf];
% compute the 2D bivariate histogram
% using 16 spatial directions and 7 speed levels
WindRose = histcounts2(winddir, windspeed, directedges, speededges);
WindRose = [WindRose(1,:)+WindRose(end,:); WindRose(2:end-1,:)];
WindRose = WindRose/sum(sum(WindRose))*100;
WindRoseStack = cumsum(WindRose, 2);
% organize the output     
if nargout
    % form windrose matrix
    windrose = WindRose;
else
    % plot the Wind Rose (layer-by-layer)
    cardinals = deg2rad(-11.25:360/16:348.75);
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 7), 'FaceColor', [0.5 0.3 0.3])
    hold on
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 6), 'FaceColor', [1.0 0.1 0.1])
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 5), 'FaceColor', [1.0 0.7 0.0])
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 4), 'FaceColor', [1.0 1.0 0.0])
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 3), 'FaceColor', [0.0 1.0 0.0])
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 2), 'FaceColor', [0.5 0.8 0.9])
    polarhistogram('BinEdges', cardinals, 'BinCounts', WindRoseStack(:, 1), 'FaceColor', [0.1 0.1 1.0])
    set(allchild(gca), 'FaceAlpha', 1)
    % set some plot properties
    ax = gca;
    ax.Layer = 'top';
    ax.GridAlpha = 0.2;
    ax.ThetaDir = 'clockwise';
    ax.ThetaZeroLocation = 'top';
    ax.ThetaTick = 0:360/16:360;
    ax.ThetaTickLabel = {'N | 0\circ', 'NNE', 'NE | 45\circ', 'ENE', 'E | 90\circ', 'ESE', 'SE | 135\circ', 'SSE', ...
                         'S | 180\circ', 'SSW', 'SW | 225\circ', 'WSW', 'W | 270\circ', 'WNW', 'NW | 315\circ', 'NNW'};
    ax.RAxisLocation = 90; 
    ax.RAxis.TickLabelFormat = '%g%%';
    ax.RMinorGrid = 'on';
    legend('24+ m/s', '20 \div 24 m/s', '16 \div 20 m/s', '12 \div 16 m/s', ...
           '8 \div 12 m/s', '4 \div 8 m/s', '0 \div 4 m/s')
end
end
function degree = cardinal2deg(cardinal)
% input validation
validateattributes(cardinal, {'cell'}, ...
                             {'vector', 'nonempty'}, ...
                             '', 'cardinal', 1)
% convert the wind direction from cardinal to deg
CardDir = {'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', ...
           'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'};
AngleDir = 0:22.5:337.5;
Dictionary = table(AngleDir(:), 'RowNames', CardDir(:), ...
                                'VariableNames', {'AngleDir'});
degree = Dictionary{cardinal, 'AngleDir'};
end