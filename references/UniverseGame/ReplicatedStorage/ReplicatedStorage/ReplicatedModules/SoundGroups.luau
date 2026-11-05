  

 

game:GetService("RunService");

return {
    _SoundGroups = {},

    GetSoundGroup = function(p1, p2) -- Line: 7, Name: GetSoundGroup
        return p1._SoundGroups[p2];
    end,

    AddSoundGroup = function(p3, p4, p5) -- Line: 10, Name: AddSoundGroup
        if p3._SoundGroups[p5] then
            warn((`[SoundGroups]: overwriting SoundGroup {p5}!\n{debug.traceback()}`));
        end;

        p3._SoundGroups[p5] = p4;
    end,

    AssignSoundToSoundGroup = function(p6, p7, p8) -- Line: 17, Name: AssignSoundToSoundGroup
        local v9 = p6._SoundGroups[p8];

        if v9 then
            p7.SoundGroup = v9;

            return;
        end;

        warn((`[SoundGroups]: attempted to assign a sound to SoundGroup {p8}, which doesn't (yet) exist!\n{debug.traceback()}`));
    end,

    AssignSoundTag = function(p10, p11) -- Line: 26, Name: AssignSoundTag
        p11:AddTag("Sound");
    end
};