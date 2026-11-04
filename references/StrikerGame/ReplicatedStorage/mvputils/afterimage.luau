 

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local _ = game:GetService("Players").LocalPlayer;
local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };
local Effects = workspace:FindFirstChild("Effects");

if not Effects then
    Effects = Instance.new("Folder");
    Effects.Name = "Effects";
    Effects.Parent = workspace;
end;

local Clones = Effects:FindFirstChild("Clones");

if not Clones then
    Clones = Instance.new("Folder");
    Clones.Name = "Clones";
    Clones.Parent = Effects;
end;

return {
    Play = function(p2) -- Line: 32, Name: Play
        -- upvalues: u1 (copy), Clones (ref), Debris (copy), TweenService (copy)
        local v3 = typeof(p2) == "table";
        assert(v3, "Data table required");
        local v4 = p2.Character and p2.Character:IsA("Model");
        assert(v4, "Data.Character must be a Model");
        local Character = p2.Character;
        local v5 = p2.Duration or 1;
        local u6 = p2.Frequency or 0.035;
        local u7 = p2.Transparency or 0.5;
        local u8 = p2.DisappearTime or 0.5;
        local u9 = p2.StartColor or Color3.fromRGB(79, 255, 66);
        local u10 = p2.FinalColor or Color3.fromRGB(116, 255, 114);
        Character.Archivable = true;
        local u11 = os.clock() + v5;
        local u12 = {};
        task.spawn(function() -- Line: 49
            -- upvalues: u11 (copy), u1 (ref), Character (copy), u7 (copy), u9 (copy), Clones (ref), u12 (copy), Debris (ref), u8 (copy), TweenService (ref), u10 (copy), u6 (copy)
            while os.clock() < u11 do
                local v13 = {};

                for _, v in ipairs(u1) do
                    local v14 = Character:FindFirstChild(v);

                    if v14 then
                        local v15;

                        if v == "Head" and v14:FindFirstChild("FaceContainer") then
                            v15 = v14.FaceContainer:Clone();
                        else
                            v15 = v14:Clone();
                        end;

                        for _, descendant in ipairs(v15:GetDescendants()) do
                            if descendant:IsA("Decal") or (descendant:IsA("Weld") or (descendant:IsA("Motor6D") or descendant:IsA("Attachment"))) then
                                descendant:Destroy();
                            end;
                        end;

                        v15.Size = v15.Size / 1.1;
                        v15.Material = Enum.Material.Neon;
                        v15.Transparency = u7;
                        v15.Color = u9;
                        v15.Anchored = true;
                        v15.CanCollide = false;
                        v15.CanQuery = false;
                        v15.Massless = true;
                        v15.CFrame = v14.CFrame;
                        v15.Parent = Clones;
                        table.insert(v13, v15);
                        table.insert(u12, v15);
                        Debris:AddItem(v15, u8);
                    end;
                end;

                for _, v in ipairs(u12) do
                    TweenService:Create(v, TweenInfo.new(u8), {
                        Transparency = 1,
                        Color = u10
                    }):Play();
                end;

                task.wait(u6);
            end;
        end);
    end
};