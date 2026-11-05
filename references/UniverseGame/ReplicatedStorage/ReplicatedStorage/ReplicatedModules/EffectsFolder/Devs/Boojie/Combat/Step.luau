  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(u1, p2) -- Line: 4
    -- upvalues: GenericModule (copy), EffectsHandler (copy)
    local u3 = p2 or {};

    if not u3.Cancel then
        local Character = u3.Character;
        local u4 = u3.Velocity or Vector3.new(0, 0, 0);
        local u5 = u3.EndVelocity or u4;
        local v6 = u3.Speed or 1;
        local u7 = u3.EndSpeed or v6;
        local u8 = u3.Direction or Vector3.new(0, 0, 0);
        local u9 = u3.Normal or Vector3.new(0, 0, 0);
        local u10 = u3.MaxForce or Vector3.new(100000, 0, 100000);
        local v11 = u3.Time or 0.2;
        local u12 = Enum.EasingStyle[u3.EasingStyle or "Linear"];
        local u13 = Enum.EasingDirection[u3.EasingDirection or "Out"];
        local u14 = v11 == (1 / 0) and 0.2 or v11;
        local u15 = u3.TimeDelay or 0;
        local Distance = u3.Distance;
        local MaxDistance = u3.MaxDistance;
        local RaycastParameters = u3.RaycastParameters;

        if not RaycastParameters then
            RaycastParameters = RaycastParams.new();
            RaycastParameters.FilterType = RaycastParameters.FilterType or Enum.RaycastFilterType.Exclude;
            local v16 = { u1, Character };

            if u3.Filter then
                for _, v in pairs(u3.Filter) do
                    table.insert(v16, v);
                end;
            end;

            RaycastParameters.FilterDescendantsInstances = v16;
            RaycastParameters.CollisionGroup = RaycastParameters.CollisionGroup or "Default";
        end;

        local u17 = u1.CFrame:VectorToWorldSpace(u9);

        local function GetDirection() -- Line: 51
            -- upvalues: u3 (ref), u8 (copy), u17 (copy), u1 (copy), u9 (copy)
            if not u3.Turn then
                return u8 + u17;
            end;

            if u3.Turn then
                return u8 + u1.CFrame:VectorToWorldSpace(u9);
            end;
        end;

        local StepVelocity = u1:FindFirstChild("StepVelocity");
        local v18;

        if StepVelocity then
            if u3.Override == false then
                return;
            end;

            StepVelocity.Parent = nil;
            v18 = true;
        else
            v18 = false;
        end;

        local function IsTimestopped() -- Line: 70
            -- upvalues: Character (copy)
            local v19 = Character and Character:GetAttribute("Timestopped") == true;

            return v19;
        end;

        local u20 = 0;
        local u21 = v6;

        local function GetVelocity() -- Line: 78
            -- upvalues: u20 (ref), u14 (ref), u12 (copy), u13 (copy), u4 (copy), u5 (copy), u3 (ref), u8 (copy), u17 (copy), u1 (copy), u9 (copy), GenericModule (ref), u21 (ref), u7 (copy), MaxDistance (copy), Distance (copy), RaycastParameters (ref)
            local v22 = math.clamp(u20 / u14, 0, 1);
            local v23 = game.TweenService:GetValue(v22, u12, u13);
            local v24 = u4 ~= u5 and u4:Lerp(u5, v23) or u4;
            local v25;

            if u3.Turn then
                if u3.Turn then
                    v25 = u8 + u1.CFrame:VectorToWorldSpace(u9);
                else
                    v25 = nil;
                end;
            else
                v25 = u8 + u17;
            end;

            local v26 = v25 * GenericModule.Lerp(u21, u7, v23);
            local Unit = v26.Unit;
            u21 = v26.Magnitude;

            if MaxDistance then
                local v27 = MaxDistance or Distance;
                local v28 = Distance or v27;
                local v29 = workspace:Raycast(u1.Position, v26, RaycastParameters);

                if v29 then
                    v28 = (u1.Position - v29.Position).Magnitude;
                end;

                u21 = GenericModule.Lerp(0, u21, math.clamp(v28, 0, v27) / v27);
                v26 = Unit * u21;
            end;

            return v24 + v26;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "StepVelocity";
        local v30;

        if Character then
            v30 = Character:GetAttribute("Timestopped") == true;
        else
            v30 = Character;
        end;

        BodyVelocity.Velocity = v30 and Vector3.new(0, 0, 0) or GetVelocity();
        BodyVelocity.MaxForce = u10;

        if v18 then
            task.defer(function() -- Line: 104
                -- upvalues: BodyVelocity (ref), u1 (copy)
                BodyVelocity.Parent = u1;
            end);
        else
            BodyVelocity.Parent = u1;
        end;

        task.spawn(function() -- Line: 110
            -- upvalues: u20 (ref), u14 (ref), u15 (copy), Character (copy), BodyVelocity (ref), u10 (copy), GetVelocity (copy), EffectsHandler (ref)
            local v31 = os.clock();

            while u20 <= u14 + u15 do
                local v32 = os.clock();
                local v33 = v32 - v31;
                local v34 = Character and Character:GetAttribute("Timestopped") == true;

                if v34 then
                    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
                    BodyVelocity.MaxForce = u10;
                else
                    u20 = u20 + v33;
                    BodyVelocity.Velocity = GetVelocity();
                end;

                EffectsHandler.Wait();
                v31 = v32;
            end;

            BodyVelocity:Destroy();
        end);

        return BodyVelocity;
    end;

    local StepVelocity = u1:FindFirstChild("StepVelocity");

    if StepVelocity then
        StepVelocity.Parent = nil;
    end;
end;