  

 

game:GetService("RunService");
game:GetService("ReplicatedStorage");
local Petal = _G.Petal;
local v1 = Petal("Util");
local u2 = Petal("Extensions");
local Tween = v1.Tween;

return function(p3) -- Line: 8
    -- upvalues: u2 (copy), Tween (copy)
    local Model = p3.Model;
    Model.Archivable = true;
    local u4 = Model:Clone();
    u4.Parent = workspace.Effects;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Shirt") or (descendant:IsA("Pants") or (descendant:IsA("ShirtGraphic") or (descendant:IsA("LuaSourceContainer") or (descendant:IsA("JointInstance") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Humanoid") or descendant:IsA("GuiBase")))))))) then
            descendant:Destroy();
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.Material = "Neon";
            descendant.Color = Color3.fromRGB(98, 56, 190);

            if descendant:FindFirstChildOfClass("SpecialMesh") then
                descendant:FindFirstChildOfClass("SpecialMesh").TextureId = "";
            elseif descendant:IsA("MeshPart") then
                descendant.TextureID = "";
            end;

            local v5 = CFrame.new(u2.Rng(-6, 6), u2.Rng(2, 4), u2.Rng(-6, 6));
            local v6 = CFrame.Angles(u2.Rng(-4.71238898038469, 4.71238898038469), u2.Rng(-4.71238898038469, 4.71238898038469), u2.Rng(-4.71238898038469, 4.71238898038469));
            Tween(descendant, 6, "Quart", "Out", {
                CFrame = descendant.CFrame * v5 * v6
            });
            Tween(descendant, 2.5, "Quad", "InOut", {
                Transparency = 1,
                Color = Color3.fromRGB(0, 0, 0)
            });
        end;
    end;

    task.delay(6, function() -- Line: 43
        -- upvalues: u4 (ref)
        u4:Destroy();
        u4 = nil;
    end);
end;