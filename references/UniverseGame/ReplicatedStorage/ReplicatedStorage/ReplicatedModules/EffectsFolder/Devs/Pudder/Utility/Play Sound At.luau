  

 

local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local SoundGroups = require(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local ParticleHandler = require(ReplicatedStorage:WaitForChild("ReplicatedModules").ReplicatedLibrary.ParticleHandler);

local function TweenCallback(p1, p2, u3, p4, p5, p6, p7, p8, p9) -- Line: 7
    -- upvalues: TweenService (copy)
    local v10 = TweenService:Create(p1, TweenInfo.new(p4 or 0.5, p5 or Enum.EasingStyle.Quad, p6 or Enum.EasingDirection.Out, p7 or 0, p8 or false, p9 or 0), p2);
    v10.Completed:Connect(function() -- Line: 17
        -- upvalues: u3 (copy)
        if u3 then
            u3();
        end;
    end);
    v10:Play();
end;

return function(p11) -- Line: 23
    -- upvalues: ParticleHandler (copy), SoundGroups (copy), ContentProvider (copy), TweenCallback (copy)
    local Object = p11.Object;
    local Origin = p11.Origin;
    local Reference = p11.Reference;
    local FadeInTime = p11.FadeInTime;
    local FadeOutTime = p11.FadeOutTime;

    if typeof(Object) == "Instance" and Object:IsA("Sound") then
        if Origin == nil and (p11.AttachTo and typeof(p11.AttachTo) == "Instance") then
            Origin = ParticleHandler.TranslateToCFrame(p11.AttachTo);
        end;

        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Transparency = 1;
        Part.CanCollide = false;
        Part.Massless = true;
        Part.Parent = workspace.Effects;
        Part.CFrame = ParticleHandler.TranslateToCFrame(Origin);
        Part.Name = Object.Name;

        if p11.AttachTo and typeof(p11.AttachTo) == "Instance" then
            ParticleHandler.AttachTo(Part, {
                Part = p11.AttachTo
            });
        elseif p11.AttachTo and typeof(p11.AttachTo) == "table" then
            ParticleHandler.AttachTo(Part, p11.AttachTo);
        end;

        local u12 = Object:Clone();

        if u12.IsPlaying then
            u12.Playing = false;
            u12.TimePosition = 0;
        end;

        u12.PlaybackSpeed = p11.PlaybackSpeed or u12.PlaybackSpeed;
        local u13 = p11.Volume or u12.Volume;
        u12.Volume = FadeInTime and 0 or u13;
        u12.RollOffMaxDistance = p11.RollOffMaxDistance or 110;
        u12.RollOffMinDistance = p11.RollOffMinDistance or 30;
        u12.RollOffMode = Enum.RollOffMode.InverseTapered;
        u12.Parent = Part;
        SoundGroups:AssignSoundTag(u12);

        if not u12.TimeLength or u12.TimeLength == 0 then
            ContentProvider:PreloadAsync({ u12.SoundId });

            if not u12.IsLoaded then
                u12.Loaded:Wait();
            end;
        end;

        u12:Play();
        u12:SetAttribute("OriginalVolume", u13);
        local u14 = false;

        if FadeInTime then
            TweenCallback(u12, {
                Volume = u13
            }, nil, FadeInTime, Enum.EasingStyle.Linear);
        end;

        if u12.Looped and (u12.TimeLength > 0 and FadeOutTime) then
            task.spawn(function() -- Line: 92
                -- upvalues: u12 (copy), FadeOutTime (copy), u14 (ref), TweenCallback (ref), u13 (copy), FadeInTime (copy)
                while u12.Parent do
                    local v15 = math.max(0, u12.TimeLength / u12.PlaybackSpeed - FadeOutTime);
                    task.wait(v15);

                    if u12.Parent then
                        u14 = true;
                        TweenCallback(u12, {
                            Volume = 0
                        }, function() -- Line: 101
                            -- upvalues: u14 (ref)
                            u14 = false;
                        end, FadeOutTime, Enum.EasingStyle.Linear);
                        task.wait(FadeOutTime);

                        if u12.Parent then
                            TweenCallback(u12, {
                                Volume = u13
                            }, nil, FadeInTime or 0.1, Enum.EasingStyle.Linear);
                            task.wait(FadeInTime or 0.1);
                        end;
                    end;
                end;
            end);
        end;

        if not u12.Looped and u12.TimeLength > 0 then
            local v16 = u12.TimeLength / u12.PlaybackSpeed;

            if FadeOutTime then
                local v17 = math.max(0, v16 - FadeOutTime);
                task.delay(v17, function() -- Line: 118
                    -- upvalues: u12 (copy), u14 (ref), TweenCallback (ref), u13 (copy), FadeOutTime (copy)
                    if u12.Parent then
                        u14 = true;
                        TweenCallback(u12, {
                            Volume = 0
                        }, function() -- Line: 124
                            -- upvalues: u12 (ref), u13 (ref), u14 (ref)
                            u12.Volume = u13;
                            u14 = false;
                        end, FadeOutTime, Enum.EasingStyle.Linear);
                    end;
                end);
            end;

            task.delay(v16, function() -- Line: 135
                -- upvalues: Part (copy)
                if Part.Parent then
                    Part:Destroy();
                end;
            end);
        end;

        if Reference then
            task.spawn(function() -- Line: 143
                -- upvalues: Reference (copy), Part (copy), u14 (ref), FadeOutTime (copy), TweenCallback (ref), u12 (copy)
                while Reference:IsDescendantOf(workspace) and Part.Parent do
                    task.wait(0.016666666666666666);
                end;

                if u14 then
                    while u14 and Part.Parent do
                        task.wait(0.016666666666666666);
                    end;
                elseif FadeOutTime then
                    u14 = true;
                    TweenCallback(u12, {
                        Volume = 0
                    }, function() -- Line: 153
                        -- upvalues: u14 (ref)
                        u14 = false;
                    end, FadeOutTime, Enum.EasingStyle.Linear);

                    while u14 and Part.Parent do
                        task.wait(0.016666666666666666);
                    end;
                end;

                if Part.Parent then
                    Part:Destroy();
                end;
            end);
        end;

        return u12, Part;
    end;
end;