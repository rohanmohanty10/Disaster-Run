 
 

local Styles = require(script.Parent.Parent:WaitForChild("Styles"));

function OFA(u1)
    -- upvalues: Styles (copy)
    task.spawn(function() -- Line: 5
        -- upvalues: Styles (ref), u1 (copy)
        Styles.ChunkCrater(u1, {
            PartCount = 20,
            Radius = 10,
            Angle = { 45, 65 },
            Tilt = { -15, 15 },
            Height = { -0.5, 0.8 },
            BlockSize = { 1.25, 2 },
            IterateSpeed = {
                Entrance = 0.1,
                EntranceDivision = 2,
                Exit = 0.25,
                ExitDivision = 2
            }
        });
    end);
    task.spawn(function() -- Line: 22
        -- upvalues: Styles (ref), u1 (copy)
        Styles.Break(u1, {
            Radius = 15,
            PartCount = 15,
            BlockSize = { 0.25, 3 },
            Height = { 15, 25 },
            Angle = { -5, 5 },
            Tilt = { -5, 5 },
            Width = { -35, 35 },
            IterateSpeed = {
                Entrance = 0.1,
                EntranceDivision = 2,
                Exit = 0.25,
                ExitDivision = 2
            }
        });
    end);
    Styles.ChunkCrater(u1, {
        PartCount = 20,
        Radius = 15,
        Angle = { 45, 65 },
        Tilt = { -15, 15 },
        Height = { -0.5, 0.8 },
        BlockSize = { 2, 3 },
        IterateSpeed = {
            Entrance = 0.1,
            EntranceDivision = 2,
            Exit = 0.25,
            ExitDivision = 2
        }
    });
end;

return OFA;