  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = require("./standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return function(u2) -- Line: 7
    -- upvalues: u1 (copy), Trove (copy), ReplicatedStorage (copy), Players (copy)
    return u1({
        animationId = "rbxassetid://95196462360404",
        looped = true,
        meta = {
            rarity = "Limited"
        },

        effect = function(p3, p4, p5) -- Line: 12, Name: effect
            -- upvalues: Trove (ref), ReplicatedStorage (ref), u2 (copy), Players (ref)
            local v6 = Trove.new();
            local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
            local v7 = p3:FindFirstChild("Left Arm");
            local v8 = ReplicatedStorage.Assets.Misc.GoalEmote:Clone();
            v8.Parent = HumanoidRootPart;

            for _, child in v8:GetChildren() do
                local v9 = child:FindFirstChildOfClass("Motor6D");

                if v9 and v7 then
                    v9.Part0 = v7;
                    v9.Part1 = child;
                end;
            end;

            v6:Add(v8);
            local v10 = ReplicatedStorage.Assets.ClubAuras:FindFirstChild(u2);
            local Torso = p3:FindFirstChild("Torso");

            if v10 and Torso then
                local v11 = v10:Clone();
                v11.Name = "GoalAura";
                v11.Anchored = false;
                v11.CanCollide = false;
                v11.CanQuery = false;
                v11.CanTouch = false;
                v11.Massless = true;

                for _, descendant in v11:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
                        descendant.Enabled = true;
                    end;
                end;

                v11.CFrame = Torso.CFrame;
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = Torso;
                WeldConstraint.Part1 = v11;
                WeldConstraint.Parent = v11;
                v11.Parent = p3.HumanoidRootPart;
                v6:Add(v11);
            end;

            local v12 = v8.PrimaryPart or v8:FindFirstChildWhichIsA("MeshPart");

            if v12 then
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);
                local v13 = PlayerFromCharacter and PlayerFromCharacter:GetAttribute("NELWins") or 0;
                local BillboardGui = Instance.new("BillboardGui");
                BillboardGui.Name = "GoalWinsBB";
                BillboardGui.Adornee = v12;
                BillboardGui.Size = UDim2.new(0, 90, 0, 26);
                BillboardGui.StudsOffset = Vector3.new(0, 0, -1.6);
                BillboardGui.AlwaysOnTop = true;
                BillboardGui.MaxDistance = 90;
                local TextLabel = Instance.new("TextLabel");
                TextLabel.BackgroundTransparency = 1;
                TextLabel.Size = UDim2.fromScale(1, 1);
                TextLabel.Font = Enum.Font.GothamBlack;
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                TextLabel.TextStrokeTransparency = 0;
                TextLabel.TextScaled = true;
                TextLabel.Text = tostring(v13) .. " NEL Wins";
                TextLabel.Parent = BillboardGui;
                BillboardGui.Parent = v12;
                v6:Add(BillboardGui);
            end;

            return v6;
        end
    });
end;