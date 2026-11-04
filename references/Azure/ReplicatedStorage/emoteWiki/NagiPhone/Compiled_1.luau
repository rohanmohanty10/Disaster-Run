 
 

return {
    { 162, function(p1) -- Line: 3
            p1.the.PointLight.Enabled = true;
            shared.vfx.emit(table.unpack(p1));
        end },
    { 308, function(p2) -- Line: 9
            p2.the.PointLight.Enabled = false;
        end }
};