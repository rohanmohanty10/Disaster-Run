  

 

local v1 = {};
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local TagService = require(Core.ReplicatedServices.TagService);

function v1.Init(p2) -- Line: 8
    -- upvalues: TagService (copy), Trove (copy)
    function p2.GetTimescale(p3) -- Line: 9
        -- upvalues: TagService (ref)
        local v4 = TagService.GetContainer(p3);

        if not v4 then
            return 1;
        end;

        if TagService.GetTag(v4, "FreezeTimescale") then
            return 0;
        end;

        local v5 = TagService.CalculateTagTotal(v4, "Timescale", 1);
        local v6 = TagService.CalculateTagTotal(v4, "TemporalTimescale", 1);

        return v5 * math.max(0.25, v6);
    end;

    local u7 = {};

    function p2.SetAnimationSpeedModifier(u8, u9) -- Line: 27
        -- upvalues: u7 (copy), Trove (ref)
        local u10 = u7[u8];

        if u10 then
            if u9 == nil then
                for i in pairs(u10.Animations) do
                    i:AdjustSpeed(i:GetAttribute("__OriginalSpeed") or 1);
                end;

                u10.Collector:Destroy();
            else
                u10.Speed = u9;

                for i in pairs(u10.Animations) do
                    i:AdjustSpeed((i:GetAttribute("__OriginalSpeed") or 1) * u9);
                end;
            end;
        elseif not u10 and u9 ~= nil then
            local v11 = u8:FindFirstChildWhichIsA("Humanoid");
            local v12;

            if v11 then
                v12 = v11:FindFirstChild("Animator") or nil;
            else
                v12 = nil;
            end;

            if not (v11 and v12) then
                return;
            end;

            u10 = {
                Active = true,
                Character = u8,
                Collector = Trove.new(),
                Speed = u9,
                Animations = {}
            };
            u7[u8] = u10;
            u10.Collector:Connect(u8.AncestryChanged, function() -- Line: 60
                -- upvalues: u8 (copy), u10 (ref)
                if not (u8 and u8:IsDescendantOf(game)) then
                    u10.Collector:Destroy();
                end;
            end);
            u10.Collector:Add(function() -- Line: 66
                -- upvalues: u10 (ref), u7 (ref), u8 (copy)
                if table.isfrozen(u10) then
                    return;
                end;

                u10.Active = false;

                for i in pairs(u10.Animations) do
                    local v13 = i:GetAttribute("__OriginalSpeed");

                    if v13 then
                        i:AdjustSpeed(v13);
                    else
                        i:AdjustSpeed(1);
                    end;
                end;

                u7[u8] = nil;
                table.clear(u10);
                table.freeze(u10);
            end);

            local function AddTrack(p14) -- Line: 87
                -- upvalues: u10 (ref), u9 (copy)
                if p14:GetAttribute("SequenceTrack") then
                    return;
                end;

                local v15 = p14:GetAttribute("__OriginalSpeed");

                if not v15 then
                    v15 = p14.Speed;
                    p14:SetAttribute("__OriginalSpeed", p14.Speed);
                end;

                if not u10.Active then
                    return;
                end;

                if not u10.Animations[p14] then
                    u10.Animations[p14] = true;
                    p14:AdjustSpeed(v15 * u9);
                end;
            end;

            if v11 then
                for _, v in pairs(v11:GetPlayingAnimationTracks()) do
                    task.spawn(AddTrack, v);
                end;

                u10.Collector:Connect(v11.AnimationPlayed, AddTrack);
            end;

            if v12 then
                for _, v in pairs(v12:GetPlayingAnimationTracks()) do
                    task.spawn(AddTrack, v);
                end;

                u10.Collector:Connect(v12.AnimationPlayed, AddTrack);
            end;
        end;

        return u10 and u10.Collector or nil;
    end;
end;

return v1;