%% BPS spectra in SU3 - wild chamber - Log data
%% Section 4 of the paper barcodes&walls

clc; 
clear; 
close all;
%% BPS SU3 wild

%% set the parameters

max_dimension=2
max_filtration_value=7
num_divisions=100
over_integers=2

%% create the set of points
load ('SU3DTwildLog.mat')
point_cloud = SU3DTwildLog;
size(point_cloud)

%% create a Vietoris-Rips stream
stream=api.Plex4.createVietorisRipsStream(point_cloud,max_dimension,max_filtration_value,num_divisions);
num_simplices = stream.getSize()

%% get persistence algorithm over Z/2Z
persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension, over_integers);

% compute the intervals
intervals= persistence.computeIntervals(stream);

% create the barcode plots
options.filename = 'SU3DTwildLogBarcodes';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
options.side_by_side = true;
options.caption='SU3 wild Log';
plot_barcodes(intervals, options);

% get the infinite barcodes
infinite_barcodes = intervals.getInfiniteIntervals();

% print out betti numbers array
betti_numbers_array = infinite_barcodes.getBettiSequence()
