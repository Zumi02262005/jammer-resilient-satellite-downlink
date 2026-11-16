function fig = plot_ber_curves(x, berSim, berTh, names, ttl, xlab)
%PLOT_BER_CURVES Simulated BER (markers) against theory (lines) on a log axis.
%
%   x      - sweep values (J/S or Eb/N0 in dB)
%   berSim - nCurves x numel(x) simulated BER (zeros are not plotted)
%   berTh  - nCurves x numel(x) theoretical BER ([] to skip)
%   names  - cell array of curve names
%   ttl    - figure title
%   xlab   - x-axis label
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

cols = [0 0.45 0.74; 0.85 0.33 0.10; 0.47 0.67 0.19; 0.49 0.18 0.56];
mk   = {'o', 's', '^', 'd'};
fig = figure('Color', 'w'); hold on;
leg = {};
for i = 1:size(berSim, 1)
    c = cols(mod(i-1, size(cols,1)) + 1, :);
    y = berSim(i, :); y(y == 0) = NaN;
    semilogy(x, y, mk{mod(i-1, numel(mk)) + 1}, 'Color', c, ...
        'MarkerFaceColor', c, 'MarkerSize', 5, 'LineStyle', 'none');
    leg{end+1} = [names{i} ' (simulated)']; %#ok<AGROW>
    if ~isempty(berTh)
        semilogy(x, berTh(i, :), '-', 'Color', c, 'LineWidth', 1.3);
        leg{end+1} = [names{i} ' (theory)']; %#ok<AGROW>
    end
end
set(gca, 'YScale', 'log'); grid on; box on;
ylim([1e-7 1]); xlim([min(x) max(x)]);
xlabel(xlab); ylabel('Bit error rate (BER)'); title(ttl);
legend(leg, 'Location', 'southeast', 'FontSize', 8);
hold off;
end
