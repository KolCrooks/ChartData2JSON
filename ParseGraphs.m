scatterTable = readtable('IQ.csv');
histoTable = readtable('pearson correlation.csv');

% Setup output struct
outputData = OutputData;

outputData.name = '';
outputData.description = '';
outputData.id = -1;
outputData.scatterplotData = [];
outputData.histogramData = [];


% Construct Scatterplot Data
for i = 2:width(scatterTable)
    tempData = GraphData;
    tempData.values = scatterTable.(i);
    
    % Only add description if there is one to add
    if length(scatterTable.Properties.VariableDescriptions) >= i
        tempData.description = cell2mat(scatterTable.Properties.VariableDescriptions(i));
    else
       tempData.description = '';
    end
    
    % Only add Name if there is one to add
    if length(scatterTable.Properties.VariableNames) >= i
        tempData.name = cell2mat(scatterTable.Properties.VariableNames(i));
    else
       tempData.name = sprintf('Var_%d',i);
    end
    
    % Append the temp data to the output struct
    outputData.scatterplotData = [outputData.scatterplotData, tempData];
end
for i = 2:width(histoTable)
    tempData = GraphData;
    tempData.values = histoTable.(i);
    
    % Only add description if there is one to add
    if length(histoTable.Properties.VariableDescriptions) >= i
        tempData.description = cell2mat(histoTable.Properties.VariableDescriptions(i));
    else
       tempData.description = '';
    end
    
    % Only add Name if there is one to add
    if length(scatterTable.Properties.VariableNames) >= i
        tempData.name = cell2mat(histoTable.Properties.VariableNames(i));
    else
       tempData.name = sprintf('Var_%d',i);
    end
    
    % Append the temp data to the output struct
    outputData.histogramData = [outputData.histogramData, tempData];
end

% Log some data
disp(outputData);
jsonOut = jsonencode(outputData);
disp(jsonOut);

% Write data to jason
writeTo = fopen(sprintf('Graph_Output_%d.json',floor(now*10000000)),'w');
fprintf(writeTo, jsonOut);
fclose(writeTo);
