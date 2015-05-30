function [ output_args ] = EraseQTMesh( input_args )
QTGlobals
for i = 1:length(FigMesh)
    delete(FigMesh{i});
end

FigMesh = {};

end

