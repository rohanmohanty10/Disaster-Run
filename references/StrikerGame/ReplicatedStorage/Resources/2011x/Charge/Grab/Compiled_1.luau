 
 

return {
    { 0, function(p1) -- Line: 3
            shared.vfx.emit(p1["first hit"]);
        end },
    { 74, function(p2) -- Line: 8
            shared.vfx.emit(p2["neck goes boom"]);
        end },
    { 131, function(p3) -- Line: 13
            shared.vfx.emit(p3.throweffect);
        end }
};