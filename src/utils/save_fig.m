function save_fig(fig, folder, name)
%SAVE_FIG Save a figure as a 200-dpi PNG in the given folder.
%
%   Part of: Jammer-Resilient Satellite Downlink (DIGDACM term project)

if ~exist(folder, 'dir'), mkdir(folder); end
print(fig, fullfile(folder, [name '.png']), '-dpng', '-r200');
end
