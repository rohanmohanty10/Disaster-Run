 
 

local function emit(p1) -- Line: 3
    if p1 then
        shared.vfx.emit(p1);
    end;
end;

local function torso_vfx(p2, p3) -- Line: 9
    if p2 then
        p2 = p2:FindFirstChild("Torso");
    end;

    if p2 then
        p2 = p2:FindFirstChild(p3);
    end;

    return p2;
end;

return {
    { 443, function(p4, p5, p6) -- Line: 16
            local remielle = p6.remielle;

            if remielle then
                remielle = remielle:FindFirstChild("Torso");
            end;

            if remielle then
                remielle = remielle:FindFirstChild("RemielleVFX");
            end;

            if remielle then
                shared.vfx.emit(remielle);
            end;
        end },
    { 816, function(p7, p8, p9) -- Line: 21
            local wise = p9.wise;

            if wise then
                wise = wise:FindFirstChild("Torso");
            end;

            if wise then
                wise = wise:FindFirstChild("WiseVFX");
            end;

            if wise then
                shared.vfx.emit(wise);
            end;
        end },
    { 1156, function(p10) -- Line: 26
            local funny = p10.Part:FindFirstChild("funny");

            if funny then
                shared.vfx.emit(funny);
            end;
        end },
    { 1201, function(p11) -- Line: 31
            local Attachment = p11.Part:FindFirstChild("Attachment");

            if Attachment then
                shared.vfx.emit(Attachment);
            end;
        end },
    { 1271, function(p12) -- Line: 36
            local light1 = p12:FindFirstChild("light1");

            if light1 then
                shared.vfx.emit(light1);
            end;
        end },
    { 1523, function(p13) -- Line: 41
            local camerathing = p13:FindFirstChild("camerathing");

            if camerathing then
                shared.vfx.emit(camerathing);
            end;

            local light2 = p13:FindFirstChild("light2");

            if light2 then
                shared.vfx.emit(light2);
            end;
        end }
};