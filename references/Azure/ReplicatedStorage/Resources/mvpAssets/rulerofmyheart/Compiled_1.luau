 
 

local function emit(p1: userdata?) -- Line: 7
    local shared_vfx = shared.vfx;

    if p1 and (shared_vfx and shared_vfx.emit) then
        shared_vfx.emit(p1);
    end;
end;

local function user_vfx(p2: table, p3: string) -- Line: 14
    local user = p2.user;

    if user then
        user = user:FindFirstChild("HumanoidRootPart");
    end;

    if user then
        user = user:FindFirstChild(p3);
    end;

    return user;
end;

local function scene2(p4: userdata) -- Line: 20
    local v5 = p4:FindFirstChild("alien stage map");

    if v5 then
        v5 = v5:FindFirstChild("RootPart");
    end;

    if v5 then
        v5 = v5:FindFirstChild("Scene2Lighting");
    end;

    return v5;
end;

local function flare(p6: userdata, p7: string) -- Line: 26
    local v8 = p6:FindFirstChild("alien stage map");

    if v8 then
        v8 = v8:FindFirstChild("RootPart");
    end;

    if v8 then
        v8 = v8:FindFirstChild("Scene2Lighting");
    end;

    if v8 then
        v8 = v8:FindFirstChild(p7);
    end;

    if v8 then
        v8 = v8:FindFirstChild("Flareza");
    end;

    return v8;
end;

return {
    { 132, function(p9: userdata, p10: table) -- Line: 33
            local user = p10.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("I");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 152, function(p11: userdata, p12: table) -- Line: 34
            local user = p12.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("Don\'t");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 183, function(p13: userdata, p14: table) -- Line: 35
            local user = p14.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("Believe");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 216, function(p15: userdata, p16: table) -- Line: 36
            local user = p16.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("you");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 234, function(p17: userdata, p18: table) -- Line: 37
            local user = p18.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("YOU\'RE");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 251, function(p19: userdata, p20: table) -- Line: 38
            local user = p20.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("A");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 287, function(p21: userdata, p22: table) -- Line: 39
            local user = p22.user;

            if user then
                user = user:FindFirstChild("HumanoidRootPart");
            end;

            if user then
                user = user:FindFirstChild("LIAR");
            end;

            local shared_vfx = shared.vfx;

            if user and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(user);
            end;
        end },
    { 357, function(p23: userdata, p24: table) -- Line: 40
            p24.set_phase(1);
        end },
    { 362, function(p25: userdata) -- Line: 41
            local ScreenVFXlighting1 = p25:FindFirstChild("ScreenVFXlighting1");
            local shared_vfx = shared.vfx;

            if ScreenVFXlighting1 and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(ScreenVFXlighting1);
            end;
        end },
    { 1314, function(p26: userdata, p27: table) -- Line: 42
            p27.set_phase(2);
        end },
    { 1489, function(p28: userdata) -- Line: 43
            local v29 = p28:FindFirstChild("alien stage map");

            if v29 then
                v29 = v29:FindFirstChild("RootPart");
            end;

            if v29 then
                v29 = v29:FindFirstChild("Scene2Lighting");
            end;

            if v29 then
                v29 = v29:FindFirstChild("Flare3");
            end;

            if v29 then
                v29 = v29:FindFirstChild("Flareza");
            end;

            local shared_vfx = shared.vfx;

            if v29 and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(v29);
            end;

            local v30 = p28:FindFirstChild("alien stage map");

            if v30 then
                v30 = v30:FindFirstChild("RootPart");
            end;

            if v30 then
                v30 = v30:FindFirstChild("Scene2Lighting");
            end;

            if v30 then
                v30 = v30:FindFirstChild("Flare2");
            end;

            if v30 then
                v30 = v30:FindFirstChild("Flareza");
            end;

            local shared_vfx2 = shared.vfx;

            if v30 and (shared_vfx2 and shared_vfx2.emit) then
                shared_vfx2.emit(v30);
            end;

            local v31 = p28:FindFirstChild("alien stage map");

            if v31 then
                v31 = v31:FindFirstChild("RootPart");
            end;

            if v31 then
                v31 = v31:FindFirstChild("Scene2Lighting");
            end;

            if v31 then
                v31 = v31:FindFirstChild("Flare1");
            end;

            if v31 then
                v31 = v31:FindFirstChild("Flareza");
            end;

            local shared_vfx3 = shared.vfx;

            if v31 and (shared_vfx3 and shared_vfx3.emit) then
                shared_vfx3.emit(v31);
            end;

            local v32 = p28:FindFirstChild("alien stage map");

            if v32 then
                v32 = v32:FindFirstChild("RootPart");
            end;

            if v32 then
                v32 = v32:FindFirstChild("Scene2Lighting");
            end;

            if v32 then
                v32 = v32:FindFirstChild("Flare3");
            end;

            if v32 then
                v32 = v32:FindFirstChild("Attachment");
            end;

            if v32 then
                v32 = v32:FindFirstChild("Stylized Chromatic Water Lens 4x4");
            end;

            local shared_vfx4 = shared.vfx;

            if v32 and (shared_vfx4 and shared_vfx4.emit) then
                shared_vfx4.emit(v32);
            end;
        end },
    { 1606, function(p33: userdata) -- Line: 52
            local v34 = p33:FindFirstChild("alien stage map");

            if v34 then
                v34 = v34:FindFirstChild("RootPart");
            end;

            if v34 then
                v34 = v34:FindFirstChild("Scene2Lighting");
            end;

            if v34 then
                v34 = v34:FindFirstChild("Flarez");
            end;

            local shared_vfx = shared.vfx;

            if v34 and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(v34);
            end;
        end },
    { 1611, function(p35: userdata) -- Line: 56
            local ScreenEnd = p35:FindFirstChild("ScreenEnd");
            local shared_vfx = shared.vfx;

            if ScreenEnd and (shared_vfx and shared_vfx.emit) then
                shared_vfx.emit(ScreenEnd);
            end;
        end }
};