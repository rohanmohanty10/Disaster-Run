 

 

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

local function sortedKeys(p2) -- Line: 13
    local v3 = {};

    for i, _ in pairs(p2) do
        local v4 = tonumber(i);

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    table.sort(v3);

    return v3;
end;

local function getPrevAndNextKeyFrames(p5, p6) -- Line: 23
    -- upvalues: sortedKeys (copy)
    local v7 = sortedKeys(p5);

    if #v7 == 0 then
        return nil, nil, (1 / 0);
    end;

    if v7[#v7] <= p6 then
        return v7[#v7], nil, (1 / 0);
    end;

    for i = 1, #v7 do
        if p6 < v7[i] then
            local v8 = v7[i];

            return v7[i - 1], v8, v8 - p6;
        end;

        local _ = i;
    end;

    return v7[#v7], nil, (1 / 0);
end;

function u1.new() -- Line: 44
    -- upvalues: u1 (copy)
    local v9 = setmetatable({}, u1);
    v9.connections = {};
    v9.followPart = nil;
    v9.debug = false;
    v9.currentTime = 0;

    return v9;
end;

function u1.PlayBulk(u10: table, p11: table) -- Line: 54
    for i, v in pairs(p11) do
        task.spawn(function() -- Line: 56
            -- upvalues: u10 (copy), i (copy), v (copy)
            u10:Play(i, v);
        end);
    end;
end;

function u1.Play(u12: table, u13: any, p14: table) -- Line: 62
    -- upvalues: RunService (copy), getPrevAndNextKeyFrames (copy)
    local u15;

    if typeof(p14) == "table" then
        u15 = p14[1] or p14;
    else
        u15 = p14;
    end;

    local v16;

    if typeof(p14) == "table" then
        v16 = p14[2] or nil;
    else
        v16 = nil;
    end;

    local v17 = {};

    if typeof(u13) == "function" and typeof(v16) == "string" then
        for _, child in u15:GetChildren() do
            if child:IsA("Folder") and (child:FindFirstChild("name") and child:FindFirstChild("name").Value == v16) then
                v17[tonumber(child.Name)] = child.name.Value;
            end;
        end;

        for i, v in v17 do
            task.spawn(function() -- Line: 88
                -- upvalues: v (copy), u12 (copy), RunService (ref), i (copy), u13 (copy)
                local u18 = tick();
                local u19 = "Marker" .. v .. u18;
                u12.connections[u19] = RunService.PreRender:Connect(function(p20) -- Line: 92
                    -- upvalues: u12 (ref), i (ref), v (ref), u13 (ref), u19 (ref), u18 (ref)
                    if i <= u12.currentTime then
                        if u12.debug then
                            warn(v);
                        end;

                        pcall(u13);

                        if u12.connections and u12.connections[u19] then
                            u12.connections[u19]:Disconnect();

                            if u12.debug then
                                warn("disconnected");
                            end;

                            u18 = nil;
                            u19 = nil;
                        end;
                    end;
                end);
            end);
        end;
    elseif u13:IsA("Camera") and typeof(v16) == "Instance" then
        u12.followPart = v16;
        task.spawn(function() -- Line: 122
            -- upvalues: u12 (copy), RunService (ref), u13 (copy), u15 (copy)
            u12.connections.Camera = RunService.PreRender:Connect(function(p21) -- Line: 123
                -- upvalues: u12 (ref), u13 (ref), u15 (ref)
                if u12.currentTime / 60 >= 50 and u12.currentTime / 60 < 50 then
                    warn("this connection is longer than expected, perhaps is it a memory leak?");
                end;

                if u12.followPart then
                    u13.CFrame = u12.followPart.CFrame;
                    u13.CameraType = Enum.CameraType.Scriptable;
                end;

                local v22 = u15:FindFirstChild((math.ceil(u12.currentTime)));

                if v22 and v22:IsA("NumberValue") then
                    u13.FieldOfView = v22.Value;
                end;
            end);
        end);
    else
        for _, child in u15:GetChildren() do
            v17[child.Name] = {};
            local v23 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("Folder") then
                    local v24 = tonumber(child2.Name);
                    v17[v23.Name][v24] = child2.Values["0"].Value;
                end;
            end;
        end;

        for i, v in v17 do
            task.spawn(function() -- Line: 157
                -- upvalues: u15 (copy), i (copy), u12 (copy), RunService (ref), getPrevAndNextKeyFrames (ref), v (copy), u13 (copy)
                local u25 = u15.Name .. i;
                u12.connections[u25] = RunService.PreRender:Connect(function(p26) -- Line: 159
                    -- upvalues: u12 (ref), getPrevAndNextKeyFrames (ref), v (ref), u25 (copy), u15 (ref), i (ref), u13 (ref)
                    local v27, v28;

                    if u12.currentTime then
                        local v29;
                        v27, v28, v29 = getPrevAndNextKeyFrames(v, u12.currentTime);
                    else
                        v28 = nil;
                        v27 = nil;
                    end;

                    if not v28 then
                        if u12.connections and u12.connections[u25] then
                            u12.connections[u25]:Disconnect();
                        end;

                        if u12.debug then
                            warn("disconnected " .. u15.Name .. " " .. i);
                        end;

                        return;
                    end;

                    if not v27 then
                        v27 = 0;

                        if v[v27] == nil then
                            if u13:IsA("BlurEffect") and i == "Size" then
                                u13.Size = 0;
                            end;

                            v[v27] = u13[i];

                            if u12.debug then
                                warn(u13.Name .. ":" .. i .. " setting value to object value, because current keyframe couldnt be found");
                            end;
                        end;
                    end;

                    local v30 = v[v27];
                    local v31 = v[v28];

                    if v30 == nil or v31 == nil then
                        warn("missing keyframe value:", v27, v28, "cur_frame:", u12.currentTime);

                        return;
                    end;

                    local v32 = v28 == v27 and 0 or (u12.currentTime - v27) / (v28 - v27);

                    if typeof(u13[i]) == "Color3" then
                        u13[i] = v30:Lerp(v31, v32);

                        return;
                    end;

                    if typeof(u13[i]) == "boolean" then
                        if v28 <= u12.currentTime and u13[i] ~= v31 then
                            u13[i] = v31;
                        end;
                    else
                        u13[i] = math.lerp(v30, v31, v32);
                    end;
                end);
            end);
        end;
    end;

    if u12.connections and not u12.connections.currentTime then
        u12.connections.currentTime = RunService.PreRender:Connect(function(p33) -- Line: 235
            -- upvalues: u12 (copy)
            local v34 = u12;
            v34.currentTime = v34.currentTime + p33 * 60;
        end);
    end;
end;

function u1.Debug(p35, p36) -- Line: 242
    if p36 == true then
        warn("debug set to true");
    end;

    p35.debug = p36;
end;

function u1.Destroy(p37) -- Line: 250
    for i, v in p37.connections do
        if v and v.Connected then
            v:Disconnect();

            if p37.debug then
                warn("forced disconnected " .. i);
            end;

            p37.connections[i] = nil;
        end;
    end;

    if p37.debug then
        warn("cleared all connections");
    end;

    p37.connections = {};
    table.clear(p37);
end;

return u1;