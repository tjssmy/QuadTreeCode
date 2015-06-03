
function [x,y,v] = AddQTBlockSurfacePnts(block, x,y,v,var)

QTGlobals

if ~block.br(RIGHT)
    x(end+1) = block.x + block.dx/2;
    y(end+1) = block.y;
    
    if isnan(block.bc(RIGHT,var)) % floating
        v(end+1) = block.data(var);
    else
        v(end+1) = block.bc(RIGHT,var);
    end
end

if ~block.br(LEFT)
    x(end+1) = block.x - block.dx/2;
    y(end+1) = block.y;
    
    if isnan(block.bc(LEFT,var)) % floating
        v(end+1) = block.data(var);
    else
        v(end+1) = block.bc(LEFT,var);
    end
end

if ~block.br(UP)
    x(end+1) = block.x;
    y(end+1) = block.y + block.dy/2;
    
    if isnan(block.bc(UP,var)) % floating
        v(end+1) = block.data(var);
    else
        v(end+1) = block.bc(UP,var);
    end
end

if ~block.br(DOWN)
    x(end+1) = block.x;
    y(end+1) = block.y - block.dy/2;
    
    if isnan(block.bc(DOWN,var)) % floating
        v(end+1) = block.data(var);
    else
        v(end+1) = block.bc(DOWN,var);
    end
end

if  ~block.br(UP) && ~block.br(RIGHT)
    x(end+1) = block.x + block.dx/2;
    y(end+1) = block.y + block.dy/2;
    
    if isnan(block.bc(UP,var)) && isnan(block.bc(RIGHT,var)) % floating
        v(end+1) = block.data(var);
    elseif ~isnan(block.bc(UP,var)) && ~isnan(block.bc(RIGHT,var))
        v(end+1) = (block.bc(UP,var) + block.bc(RIGHT,var))/2;
    elseif ~isnan(block.bc(UP,var))
        v(end+1) = block.bc(UP,var);
    else
        v(end+1) = block.bc(RIGHT,var);
    end
end

if  ~block.br(UP) && ~block.br(LEFT)
    x(end+1) = block.x - block.dx/2;
    y(end+1) = block.y + block.dy/2;
    
    if isnan(block.bc(UP,var)) && isnan(block.bc(LEFT,var)) % floating
        v(end+1) = block.data(var);
    elseif ~isnan(block.bc(UP,var)) && ~isnan(block.bc(LEFT,var))
        v(end+1) = (block.bc(UP,var) + block.bc(LEFT,var))/2;
    elseif ~isnan(block.bc(UP,var))
        v(end+1) = block.bc(UP,var);
    else
        v(end+1) = block.bc(LEFT,var);
    end
end

if  ~block.br(DOWN) && ~block.br(RIGHT)
    x(end+1) = block.x + block.dx/2;
    y(end+1) = block.y - block.dy/2;
    
    if isnan(block.bc(DOWN,var)) && isnan(block.bc(RIGHT,var)) % floating
        v(end+1) = block.data(var);
    elseif ~isnan(block.bc(DOWN,var)) && ~isnan(block.bc(RIGHT,var))
        v(end+1) = (block.bc(DOWN,var) + block.bc(RIGHT,var))/2;
    elseif ~isnan(block.bc(DOWN,var))
        v(end+1) = block.bc(DOWN,var);
    else
        v(end+1) = block.bc(RIGHT,var);
    end
end

if  ~block.br(DOWN) && ~block.br(LEFT)
    x(end+1) = block.x - block.dx/2;
    y(end+1) = block.y - block.dy/2;
    
    if isnan(block.bc(DOWN,var)) && isnan(block.bc(LEFT,var)) % floating
        v(end+1) = block.data(var);
    elseif ~isnan(block.bc(DOWN,var)) && ~isnan(block.bc(LEFT,var))
        v(end+1) = (block.bc(DOWN,var) + block.bc(LEFT,var))/2;
    elseif ~isnan(block.bc(DOWN,var))
        v(end+1) = block.bc(DOWN,var);
    else
        v(end+1) = block.bc(LEFT,var);
    end
end

end

