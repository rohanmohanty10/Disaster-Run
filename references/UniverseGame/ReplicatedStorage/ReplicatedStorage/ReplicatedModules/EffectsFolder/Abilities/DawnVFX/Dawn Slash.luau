  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2) -- Line: 7
    -- upvalues: u1 (copy), ParticleHandler (copy)
    if not (p2 and (p2.Part and p2.Part:IsDescendantOf(workspace))) then
        return;
    end;

    local v3 = { "", "rbxassetid://10427606639", "rbxassetid://10427606309", "rbxassetid://10427605947", "rbxassetid://10427598996", "rbxassetid://10427598593", "rbxassetid://10427598155", "rbxassetid://10427659512", "rbxassetid://10427597294", "rbxassetid://10427596767", "rbxassetid://10427589477", "rbxassetid://10427589055", "rbxassetid://10427588614", "rbxassetid://10427588114", "rbxassetid://10427587781", "rbxassetid://10427587434", "rbxassetid://10427581766", "rbxassetid://10427581218", "rbxassetid://10427580657", "rbxassetid://10427580263", "rbxassetid://10427579633", "rbxassetid://10427579296", "" };
    local v4 = {
        Right = CFrame.Angles(0, 0.7853981633974483, 0),
        Left = CFrame.Angles(3.141592653589793, 4.71238898038469, 0)
    };
    local v5 = u1.Dawn["Slash FX"]:Clone();
    v5.Weld.C0 = (p2.Offset or CFrame.identity) * v4[p2.Direction or "Right"];
    local Mesh = v5.Mesh;
    Mesh.Scale = Mesh.Scale / 1.5;
    v5.Weld.Part0 = p2.Part;
    local u6 = v5["Drag sparks"];
    local yes = v5.yes;
    yes.Color3 = Color3.new(0, 1, 1);
    local v7 = ParticleHandler.GetSkinInfo(p2.SkinName);
    local v8 = type(v7) == "table" and ((v7.Slash or {}).HSVShift or (v7.Metadata or {}).HSVShift);

    if v8 then
        ParticleHandler.HSVShiftParticles(v5, v8);
        yes.Color3 = ParticleHandler.HSVShift(yes.Color3, v8);
    end;

    v5.Parent = workspace.Effects;
    task.delay(5, v5.Destroy, v5);
    u6.sparks1.Enabled = true;
    u6.sparks2.Enabled = true;
    task.delay(0.2, function() -- Line: 48
        -- upvalues: u6 (copy)
        u6.sparks1.Enabled = false;
        u6.sparks2.Enabled = false;
    end);

    for _, v in ipairs(v3) do
        yes.Texture = v;
        task.wait(0.0165);
    end;
end;