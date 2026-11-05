 

 

local l__Parent__1 = script.Parent;
local l__LoadingFrame__2 = l__Parent__1.Frame.LoadingFrame;
local l__BarFrame__3 = l__LoadingFrame__2:WaitForChild("BarFrame");
local _ = l__BarFrame__3.Progress;
local _ = l__BarFrame__3.Skip;
local l__FakeFrame__4 = l__LoadingFrame__2.FakeFrame;
local l__ArrowFrame__5 = l__LoadingFrame__2:WaitForChild("ArrowFrame");
local l__FinisherFrame__6 = l__LoadingFrame__2:WaitForChild("FinisherFrame");
local l__BarrageFrame__7 = l__LoadingFrame__2:WaitForChild("BarrageFrame");
local l__TimeErase__8 = l__LoadingFrame__2:WaitForChild("TimeErase");
local l__PlayScreen__9 = l__Parent__1:WaitForChild("PlayScreen");
local l__SkipCutscene__10 = l__Parent__1:WaitForChild("SkipCutscene");
local l__Play__11 = l__Parent__1:WaitForChild("Play");
local l__Song__12 = l__Parent__1:WaitForChild("Song");
local _ = workspace.CurrentCamera;
game:GetService("RunService");
local l__ContentProvider__13 = game:GetService("ContentProvider");
local l__TweenService__14 = game:GetService("TweenService");
local l__ReplicatedStorage__15 = game:GetService("ReplicatedStorage");
local l__spawn__16 = task.spawn;
local l__delay__17 = task.delay;
local l__wait__18 = task.wait;
local function u2(p1) --[[ Line: 27 ]]
    local l__Size__19 = p1.Size;
    return {
        p1.CFrame * CFrame.new(l__Size__19.X / 2, l__Size__19.Y / 2, l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(l__Size__19.X / 2, -l__Size__19.Y / 2, l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(l__Size__19.X / 2, -l__Size__19.Y / 2, -l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(-l__Size__19.X / 2, -l__Size__19.Y / 2, -l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(-l__Size__19.X / 2, l__Size__19.Y / 2, -l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(l__Size__19.X / 2, l__Size__19.Y / 2, -l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(-l__Size__19.X / 2, -l__Size__19.Y / 2, l__Size__19.Z / 2),
        p1.CFrame * CFrame.new(-l__Size__19.X / 2, l__Size__19.Y / 2, l__Size__19.Z / 2)
    };
end;
local function u21(p3, p4, p5, p6, p7, p8) --[[ Line: 42 ]]
    -- upvalues: u2 (copy)
    local v9 = Vector3.new(p5.X, p6.Y, p5.Z);
    local v10 = RaycastParams.new();
    v10.FilterDescendantsInstances = { p7 };
    v10.FilterType = Enum.RaycastFilterType.Exclude;
    local v11 = workspace:Raycast(p5, -(p5 - v9).unit * p8, v10);
    local v12;
    if v11 then
        v12 = v11.Instance;
    else
        v12 = v11;
    end;
    if v11 then
        v11 = v11.Position;
    end;
    if v12 and v12 == p4 then
        local v13, v14, v15 = p4.CFrame:ToEulerAnglesXYZ();
        return CFrame.new(v11) * CFrame.Angles(v13, v14, v15);
    end;
    local v16 = u2(p3);
    local v17 = u2(p4);
    local v18 = nil;
    for _, v19 in pairs(v16) do
        for _, v20 in pairs(v17) do
            if (v20.p - v19.p).magnitude <= p8 then
                p8 = (v20.p - v19.p).magnitude;
                v18 = v20;
            end;
        end;
    end;
    return v18;
end;
local function u26(p22) --[[ Line: 74 ]]
    local v23 = p22;
    for v24 = 1, 3 do
        local v25 = v24 == 1 and p22.X or v24 == 2 and p22.Y;
        if not v25 then
            if v24 == 3 then
                v25 = p22.Z;
            else
                v25 = false;
            end;
        end;
        if (v24 == 1 or p22.X < v25) and ((v24 == 2 or p22.Y < v25) and (v24 == 3 or p22.Z < v25)) then
            return Vector3.new(v25 == p22.X and 0 or p22.X, v25 == p22.Y and 0 or p22.Y, v25 == p22.Z and 0 or p22.Z);
        end;
    end;
    return v23;
end;
local u27 = {};
local u28 = nil;
local u29 = 0;
local function u35(p30, p31) --[[ Line: 93 ]]
    -- upvalues: u29 (ref), u28 (ref), u27 (copy), u26 (copy), u21 (copy), u35 (copy)
    local l__PrimaryPart__20 = p31.PrimaryPart;
    u29 = u29 + 1;
    if not u28 or u29 ~= u28.Index then
        if u28 then
            table.insert(u27, u28);
        end;
        u28 = {
            Index = u29,
            Parts = {}
        };
    end;
    for _, v32 in pairs(p30:GetChildren()) do
        if v32:IsA("BasePart") then
            local l__Size__21 = v32.Size;
            local l__CFrame__22 = v32.CFrame;
            local v33 = u26(l__Size__21);
            table.insert(u28.Parts, {
                Size = l__Size__21,
                Transparency = v32.Transparency,
                CFrame = l__CFrame__22,
                Part = v32
            });
            v32.CFrame = u21(l__PrimaryPart__20, v32, l__PrimaryPart__20.CFrame.p, v32.CFrame.p, nil, 9999);
            v32.Size = v33 * 0.1;
            v32.Transparency = 1;
        end;
    end;
    local v34 = p30:findFirstChildWhichIsA("Model");
    if v34 then
        u35(v34, p31);
    end;
end;
u35(l__LoadingFrame__2.CrackedScreen.CracksModel.Cracks, l__LoadingFrame__2.CrackedScreen.CracksModel);
table.insert(u27, u28);
table.sort(u27, function(p36, p37) --[[ Line: 140 ]]
    return p36.Index < p37.Index;
end);
local _ = #u27;
l__spawn__16(function() --[[ Line: 149 ]]
    -- upvalues: l__ArrowFrame__5 (copy), l__FinisherFrame__6 (copy), l__BarrageFrame__7 (copy), l__TimeErase__8 (copy), l__FakeFrame__4 (copy), l__spawn__16 (copy), l__Parent__1 (copy), l__wait__18 (copy), l__ContentProvider__13 (copy), l__Song__12 (copy), l__Play__11 (copy), l__SkipCutscene__10 (copy), l__PlayScreen__9 (copy), l__ReplicatedStorage__15 (copy), l__TweenService__14 (copy), l__BarFrame__3 (copy), l__delay__17 (copy), l__LoadingFrame__2 (copy), u27 (copy)
    for v38 = 1, 3 do
        local v39 = v38 == l__ArrowFrame__5 and true or (v38 == 2 and l__FinisherFrame__6 or (v38 == 3 and l__BarrageFrame__7 or l__TimeErase__8));
        local _ = #v39:GetChildren();
        for _, v40 in pairs(v39:GetChildren()) do
            if v40:IsA("ImageLabel") then
                local l__Image__23 = v40.Image;
                v40.Image = "";
                v40.Image = l__Image__23;
                local v41 = v40:Clone();
                v41.Name = v39.Name .. v41.Name;
                v41.Visible = true;
                v41.Parent = l__FakeFrame__4;
                v41.Image = "";
                v41.Image = l__Image__23;
                v41.Size = UDim2.new(0, 0, 0, 0);
            end;
        end;
    end;
    local function u49(u42) --[[ Line: 189 ]]
        -- upvalues: l__FakeFrame__4 (ref), l__FinisherFrame__6 (ref), l__TimeErase__8 (ref), l__spawn__16 (ref), l__Parent__1 (ref), l__wait__18 (ref)
        local u43 = #u42:GetChildren();
        local u44 = 1 / u43;
        local function u47() --[[ Line: 193 ]]
            -- upvalues: u43 (copy), u42 (copy), l__FakeFrame__4 (ref), u44 (copy)
            for u45 = 1, u43 do
                u42[u45 > 1 and u45 - 1 or u43].Visible = false;
                u42[u45].Visible = true;
                task.spawn(function() --[[ Line: 201 ]]
                    -- upvalues: l__FakeFrame__4 (ref), u42 (ref), u45 (copy)
                    local v46 = l__FakeFrame__4:FindFirstChild(u42.Name .. u45);
                    if v46 then
                        v46:Destroy();
                    end;
                end);
                task.wait(u44);
            end;
        end;
        if u42 == l__FinisherFrame__6 then
            u47();
        elseif u42 == l__TimeErase__8 then
            l__spawn__16(function() --[[ Line: 216 ]]
                -- upvalues: l__Parent__1 (ref), l__TimeErase__8 (ref), l__wait__18 (ref)
                while l__Parent__1 and l__Parent__1.Parent do
                    for _, v48 in pairs(l__TimeErase__8.FakeFrame:GetChildren()) do
                        v48.Visible = not v48.Visible;
                    end;
                    l__wait__18(0.5);
                end;
            end);
        else
            l__spawn__16(function() --[[ Line: 226 ]]
                -- upvalues: l__Parent__1 (ref), u47 (copy)
                while l__Parent__1 and l__Parent__1.Parent do
                    u47();
                end;
            end);
        end;
    end;
    l__spawn__16(function() --[[ Line: 234 ]]
        -- upvalues: l__spawn__16 (ref), l__ArrowFrame__5 (ref), l__ContentProvider__13 (ref), u49 (copy)
        l__spawn__16(function() --[[ Line: 235 ]]
            -- upvalues: l__ArrowFrame__5 (ref), l__ContentProvider__13 (ref)
            for _, v50 in pairs(l__ArrowFrame__5:GetChildren()) do
                l__ContentProvider__13:PreloadAsync({ v50 });
            end;
        end);
        u49(l__ArrowFrame__5);
    end);
    l__spawn__16(function() --[[ Line: 245 ]]
        -- upvalues: l__spawn__16 (ref), l__BarrageFrame__7 (ref), l__ContentProvider__13 (ref), u49 (copy)
        l__spawn__16(function() --[[ Line: 246 ]]
            -- upvalues: l__BarrageFrame__7 (ref), l__ContentProvider__13 (ref)
            for _, v51 in pairs(l__BarrageFrame__7:GetChildren()) do
                l__ContentProvider__13:PreloadAsync({ v51 });
            end;
        end);
        u49(l__BarrageFrame__7);
    end);
    l__spawn__16(function() --[[ Line: 257 ]]
        -- upvalues: l__FinisherFrame__6 (ref), l__ContentProvider__13 (ref)
        for _, v52 in pairs(l__FinisherFrame__6:GetChildren()) do
            l__ContentProvider__13:PreloadAsync({ v52 });
        end;
    end);
    l__spawn__16(function() --[[ Line: 265 ]]
        -- upvalues: l__spawn__16 (ref), l__ContentProvider__13 (ref), l__TimeErase__8 (ref), u49 (copy)
        l__spawn__16(function() --[[ Line: 266 ]]
            -- upvalues: l__ContentProvider__13 (ref), l__TimeErase__8 (ref)
            for v53 = 1, 18 do
                l__ContentProvider__13:PreloadAsync({ l__TimeErase__8["TE" .. v53] });
            end;
        end);
        u49(l__TimeErase__8);
    end);
    l__Song__12:Play();
    local u54 = nil;
    l__Play__11.Changed:Connect(function(_) --[[ Line: 281 ]]
        -- upvalues: u54 (ref), l__SkipCutscene__10 (ref), l__PlayScreen__9 (ref), l__ReplicatedStorage__15 (ref), l__ArrowFrame__5 (ref), l__TweenService__14 (ref), l__BarFrame__3 (ref), l__Song__12 (ref), l__wait__18 (ref), l__spawn__16 (ref), l__delay__17 (ref), l__LoadingFrame__2 (ref), u27 (ref), u49 (copy), l__FinisherFrame__6 (ref), l__BarrageFrame__7 (ref)
        if u54 then
        else
            u54 = true;
            if l__SkipCutscene__10.Value then
                l__PlayScreen__9.Value = true;
            else
                local l__FunctionLibrary__24 = require(l__ReplicatedStorage__15:WaitForChild("Modules"):WaitForChild("FunctionLibrary"));
                require(l__ReplicatedStorage__15.Modules:WaitForChild("CameraShaker"));
                local v55 = TweenInfo.new(1, Enum.EasingStyle.Quad);
                for _, v56 in pairs(l__ArrowFrame__5:GetChildren()) do
                    l__TweenService__14:Create(v56, v55, {
                        ImageTransparency = 1
                    }):Play();
                end;
                for _, v57 in pairs(l__BarFrame__3:GetDescendants()) do
                    if v57:IsA("ImageLabel") then
                        l__TweenService__14:Create(v57, v55, {
                            ImageTransparency = 1
                        }):Play();
                    elseif v57:IsA("TextLabel") or v57:IsA("TextButton") then
                        l__TweenService__14:Create(v57, v55, {
                            TextTransparency = 1,
                            TextStrokeTransparency = 1
                        }):Play();
                    end;
                end;
                l__TweenService__14:Create(l__Song__12, v55, {
                    Volume = 0
                }):Play();
                l__wait__18(v55.Time);
                l__spawn__16(function() --[[ Line: 313 ]]
                    -- upvalues: l__FunctionLibrary__24 (copy), l__delay__17 (ref), l__LoadingFrame__2 (ref), u27 (ref), l__TweenService__14 (ref), l__wait__18 (ref), l__PlayScreen__9 (ref), u49 (ref), l__FinisherFrame__6 (ref)
                    l__FunctionLibrary__24.PlaySound({
                        Sound = "Gold Experience Requiem Finisher",
                        ClientOnly = true,
                        Volume = 0.2
                    });
                    l__delay__17(0.75, function() --[[ Line: 316 ]]
                        -- upvalues: l__LoadingFrame__2 (ref), l__FunctionLibrary__24 (ref), u27 (ref), l__TweenService__14 (ref), l__wait__18 (ref), l__PlayScreen__9 (ref)
                        l__LoadingFrame__2.CrackedScreen.Visible = true;
                        l__FunctionLibrary__24.PlaySound({
                            Sound = "Stand Heavy Punch",
                            ClientOnly = true,
                            Volume = 0.03
                        });
                        l__FunctionLibrary__24.PlaySound({
                            Sound = "GlassCrack",
                            ClientOnly = true,
                            Volume = 0.1
                        });
                        for v58, u59 in pairs(u27) do
                            local u60 = math.clamp(0.25 / v58, 0.05, 0.25);
                            coroutine.resume(coroutine.create(function() --[[ Line: 326 ]]
                                -- upvalues: u59 (copy), l__TweenService__14 (ref), u60 (copy)
                                for _, v61 in pairs(u59.Parts) do
                                    local l__Size__25 = v61.Size;
                                    local l__CFrame__26 = v61.CFrame;
                                    local l__Transparency__27 = v61.Transparency;
                                    local l__Part__28 = v61.Part;
                                    l__Part__28.Transparency = l__Transparency__27;
                                    l__TweenService__14:Create(l__Part__28, TweenInfo.new(u60, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                                        Size = l__Size__25,
                                        CFrame = l__CFrame__26
                                    }):Play();
                                end;
                            end));
                            l__wait__18(u60 / 2);
                        end;
                        l__wait__18(0);
                        l__PlayScreen__9.Value = true;
                    end);
                    u49(l__FinisherFrame__6);
                end);
                for _, v62 in pairs(l__BarrageFrame__7:GetChildren()) do
                    v62.ImageTransparency = 1;
                end;
            end;
        end;
    end);
end);