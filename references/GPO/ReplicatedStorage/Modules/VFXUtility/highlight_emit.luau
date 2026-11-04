 

local u1 = game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
return {
    ["tweenHighlight"] = function(p3, p4, p5, p6, p7, p8, p9) --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v10 = p6 or 1
        local v11 = Instance.new("Highlight")
        v11.Adornee = p3
        v11.DepthMode = p7 or Enum.HighlightDepthMode.Occluded
        v11.FillColor = p4 or Color3.new(1, 1, 1)
        v11.OutlineColor = p5 or Color3.new(1, 1, 1)
        v11.OutlineTransparency = 0
        local v12, v13
        if p8 == "Out" then
            v12 = 1
            v13 = 0
        else
            v12 = p9 or 0
            v13 = 1
        end
        v11.FillTransparency = v12
        v11.OutlineTransparency = v12
        v11.Parent = p3
        u2:Create(v11, TweenInfo.new(v10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["FillTransparency"] = v13,
            ["OutlineTransparency"] = v13
        }):Play()
        u1:AddItem(v11, v10)
        return v11
    end,
    ["pulseHighlight"] = function(p14, p15, p16, p17, p18, p19, p20, p21) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local u22 = Instance.new("Highlight")
        u22.Adornee = p14
        u22.DepthMode = p18 or Enum.HighlightDepthMode.Occluded
        u22.FillColor = p15 or Color3.new(1, 1, 1)
        u22.OutlineColor = p16 or Color3.new(1, 1, 1)
        local v23 = p17 or 0.5
        local v24 = p20 or 0
        local v25 = p21 or 1
        u22.FillTransparency = v24
        u22.OutlineTransparency = v24
        u22.Parent = p14
        local v26 = TweenInfo.new(v23, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local v27 = TweenInfo.new(v23, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
        local u28 = u2:Create(u22, v26, {
            ["FillTransparency"] = v25,
            ["OutlineTransparency"] = v25
        })
        local u29 = u2:Create(u22, v27, {
            ["FillTransparency"] = v24,
            ["OutlineTransparency"] = v24
        })
        local u30 = 0
        local u31 = p19 or 0
        local function u32() --[[ Line: 90 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u28
                [3] = u29
                [4] = u30
                [5] = u31
                [6] = u32
                [7] = u1
            --]]
            if u22 and u22.Parent then
                u28:Play()
                u28.Completed:Wait()
                if u22 and u22.Parent then
                    u29:Play()
                    u29.Completed:Wait()
                    u30 = u30 + 1
                    if u31 == 0 or u30 < u31 then
                        task.spawn(u32)
                    else
                        u1:AddItem(u22, 0.1)
                    end
                else
                    return
                end
            else
                return
            end
        end
        task.spawn(u32)
        return u22
    end,
    ["flashHighlight"] = function(p33, p34, p35, p36, p37, p38, p39) --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local u40 = Instance.new("Highlight")
        u40.Adornee = p33
        u40.DepthMode = p38 or Enum.HighlightDepthMode.Occluded
        u40.FillColor = p34 or Color3.new(1, 1, 1)
        u40.OutlineColor = p35 or Color3.new(1, 1, 1)
        u40.FillTransparency = p39
        u40.OutlineTransparency = p39
        u40.Parent = p33
        local v41 = p37 or 0.1
        local u42 = p36 or 1
        local v43 = TweenInfo.new(v41 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v44 = TweenInfo.new(v41 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local u45 = u2:Create(u40, v43, {
            ["FillTransparency"] = p39,
            ["OutlineTransparency"] = p39
        })
        local u46 = u2:Create(u40, v44, {
            ["FillTransparency"] = 1,
            ["OutlineTransparency"] = 1
        })
        local u47 = os.clock()
        local function u48() --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u40
                [2] = u47
                [3] = u42
                [4] = u1
                [5] = u45
                [6] = u46
                [7] = u48
            --]]
            if u40 and u40.Parent then
                if u42 <= os.clock() - u47 then
                    u1:AddItem(u40, 0.1)
                    return
                else
                    u45:Play()
                    u45.Completed:Wait()
                    if u40 and u40.Parent then
                        u46:Play()
                        u46.Completed:Wait()
                        task.spawn(u48)
                    end
                end
            else
                return
            end
        end
        task.spawn(u48)
        u1:AddItem(u40, u42 + 0.5)
        return u40
    end
}