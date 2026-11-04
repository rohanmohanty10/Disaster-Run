 

 

local function emitCharacterEffects(p1: any, p2: string?) -- Line: 2
    if not p2 then
        for _, v in p1 do
            shared.vfx.emit(table.unpack(v));
        end;

        return;
    end;

    local v3 = p1[p2];

    if v3 then
        shared.vfx.emit(table.unpack(v3));
    end;
end;

return {
    { 472, function(p4) -- Line: 18
            shared.vfx.emit(p4.S3["Right Arm"].burst, p4.S3["Left Arm"].burst);
        end },
    { 551, function(p5, p6) -- Line: 23
            shared.vfx.emit(p5.S3["Right Arm"].burst, p5.S3["Left Arm"].burst);

            if p6 then
                shared.vfx.emit(p6.letterboxtop, p6["letterboxbot.Bot.L"].letterboxbot);
            end;
        end },
    { 596, function(p7) -- Line: 31
            shared.vfx.emit(p7.Part:FindFirstChild("SmallSquare"), p7.Part.SmallSquare, p7.Part["Pixel Burst 70"], p7.Part["Pixel burst3412"], p7.Part["Pixel Puff FX"]);
        end },
    { 618, function(p8) -- Line: 36
            shared.vfx.emit(p8.S3["Right Arm"].burst, p8.S3["Left Arm"].burst);
        end },
    { 1001, function(p9) -- Line: 41
            shared.vfx.emit(p9.grab);
        end },
    { 1120, function(p10, p11, p12) -- Line: 46
            local v13 = p12["Right Leg"];

            if v13 then
                shared.vfx.emit(table.unpack(v13));
            end;
        end },
    { 1165, function(p14, p15, p16) -- Line: 51
            local v17 = p16["Left Leg"];

            if v17 then
                shared.vfx.emit(table.unpack(v17));
            end;
        end },
    { 1300, function(p18, p19, p20) -- Line: 56
            local v21 = p20["Right Leg"];

            if v21 then
                shared.vfx.emit(table.unpack(v21));
            end;
        end },
    { 1380, function(p22, p23, p24) -- Line: 61
            shared.vfx.emit(p22.ScreenEffect);

            for _, v in p24 do
                shared.vfx.emit(table.unpack(v));
            end;
        end },
    { 1536, function(p25, p26) -- Line: 67
            if p26 then
                shared.vfx.emit(p26["letterboxbot.Bot.R"].lordxreveal);
            end;
        end }
};