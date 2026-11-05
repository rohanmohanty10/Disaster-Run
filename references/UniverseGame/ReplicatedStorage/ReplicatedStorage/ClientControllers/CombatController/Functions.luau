  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);

return {
    Init = function(u1) -- Line: 15, Name: Init
        -- upvalues: PathShortcuts (copy)
        u1.Enums = require(PathShortcuts.EnumsModule);

        function u1.GetRelativePart(p2, p3) -- Line: 18
            local v4 = string.split(p3, ".");

            for _, v in ipairs(v4) do
                p2 = p2:FindFirstChild(v) or error(v .. " is not found within directory");
            end;

            return p2;
        end;

        function u1.GetCharacter(p5) -- Line: 27
            -- upvalues: u1 (copy)
            local v6 = nil;
            local v7 = nil;
            local v8 = nil;
            local v9 = nil;

            if typeof(p5) == "Instance" then
                if p5:IsA("Humanoid") or p5:IsA("BasePart") then
                    return u1.GetCharacter(p5.Parent);
                end;

                if p5:IsA("Model") then
                    v6 = game.Players:GetPlayerFromCharacter(p5);
                    v8 = p5:FindFirstChildWhichIsA("Humanoid");
                    v9 = p5:FindFirstChild("HumanoidRootPart");

                    if not v8 then
                        p5 = v7;
                    end;
                else
                    if p5:IsA("Player") then
                        return u1.GetCharacter(p5.Character);
                    end;

                    p5 = v7;
                end;
            else
                p5 = v7;
            end;

            return {
                Player = v6,
                Character = p5,
                Humanoid = v8,
                RootPart = v9
            };
        end;

        local u10 = RaycastParams.new();
        u10.IgnoreWater = true;
        u10.FilterType = Enum.RaycastFilterType.Include;
        u10.FilterDescendantsInstances = { workspace.Map };
        u10.CollisionGroup = "Map";

        function u1.RaycastMap(p11, p12) -- Line: 61
            -- upvalues: u10 (copy)
            return workspace:Raycast(p11, p12, u10);
        end;
    end
};