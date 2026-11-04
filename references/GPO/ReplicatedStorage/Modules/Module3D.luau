 

local u63 = {
    ["new"] = function(p1) --[[ Name: new, Line 59 ]]
        local u2 = CFrame.new()
        local u3 = 1
        local u4 = {
            ["Object3D"] = p1
        }
        local v5
        if p1:IsA("BasePart") then
            v5 = Instance.new("Model")
            v5.Name = "Model3D"
            p1.Parent = v5
            v5.PrimaryPart = p1
            u4.Object3D = v5
        else
            v5 = p1
        end
        local v6 = v5:GetDescendants()
        for v7 = 1, #v6 do
            if v6[v7]:IsA("Sound") then
                v6[v7]:Destroy()
            end
        end
        local u8 = Instance.new("ViewportFrame")
        u8.BackgroundTransparency = 1
        u4.AdornFrame = u8
        local u9 = Instance.new("Camera")
        u9.Parent = u8
        u8.CurrentCamera = u9
        local v10 = v5.PrimaryPart
        if not v10 then
            v5.PrimaryPart = v5:FindFirstChildWhichIsA("BasePart", true)
        end
        if v5.PrimaryPart then
            v5:PivotTo(CFrame.new(Vector3.new(0, 10000, 0) - v5.PrimaryPart.Position) * v5.PrimaryPart.CFrame)
            v5.PrimaryPart = v10
        end
        v5.Parent = u8
        local v11, v12 = v5:GetBoundingBox()
        local u13 = v11.p
        local v14 = v12.X
        local v15 = v12.Y
        local v16 = v12.Z
        local u17 = math.max(v14, v15, v16)
        function u4.Update(_) --[[ Line: 128 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u9
                [3] = u3
                [4] = u13
                [5] = u2
            --]]
            local v18 = u17
            local v19 = u9.FieldOfView
            local v20 = math.rad(v19)
            local v21 = v18 / math.tan(v20) * u3
            local v22 = CFrame.new(u13)
            u9.CFrame = v22 * u2 * CFrame.new(0, 0, u17 / 2 + v21)
            u9.Focus = v22
        end
        function u4.SetActive(_, p23) --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8.Visible = p23
        end
        function u4.GetActive(_) --[[ Line: 142 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            return u8.Visible
        end
        function u4.SetCFrame(_, p24) --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u17
                [3] = u9
                [4] = u3
                [5] = u13
            --]]
            u2 = p24
            local v25 = u17
            local v26 = u9.FieldOfView
            local v27 = math.rad(v26)
            local v28 = v25 / math.tan(v27) * u3
            local v29 = CFrame.new(u13)
            u9.CFrame = v29 * u2 * CFrame.new(0, 0, u17 / 2 + v28)
            u9.Focus = v29
        end
        function u4.GetCFrame(_) --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return u2
        end
        function u4.SetDepthMultiplier(_, p30) --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u17
                [3] = u9
                [4] = u13
                [5] = u2
            --]]
            u3 = p30
            local v31 = u17
            local v32 = u9.FieldOfView
            local v33 = math.rad(v32)
            local v34 = v31 / math.tan(v33) * u3
            local v35 = CFrame.new(u13)
            u9.CFrame = v35 * u2 * CFrame.new(0, 0, u17 / 2 + v34)
            u9.Focus = v35
        end
        function u4.GetDepthMultiplier(_) --[[ Line: 172 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3
        end
        function u4.Destroy(p36) --[[ Line: 179 ]]
            p36.AdornFrame:Destroy()
            p36.Object3D:Destroy()
        end
        function u4.End(p37) --[[ Line: 187 ]]
            p37:Destroy()
        end
        local v38 = {}
        setmetatable(u4, v38)
        function v38.__index(_, p39) --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u4
            --]]
            if p39 == "Camera" then
                return u8.CurrentCamera
            else
                local v40 = u4
                local v41 = rawget(v40, p39)
                if v41 == nil then
                    return u8[p39]
                else
                    return v41
                end
            end
        end
        function v38.__newindex(_, p42, p43) --[[ Line: 209 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8[p42] = p43
        end
        local v44 = u9.FieldOfView
        local v45 = math.rad(v44)
        local v46 = u17 / math.tan(v45) * u3
        local v47 = CFrame.new(u13)
        u9.CFrame = v47 * u2 * CFrame.new(0, 0, u17 / 2 + v46)
        u9.Focus = v47
        return u4
    end,
    ["Attach3D"] = function(_, u48, p49) --[[ Name: Attach3D, Line 222 ]]
        --[[
        Upvalues:
            [1] = u63
        --]]
        local u50 = u63.new(p49)
        u50.AnchorPoint = Vector2.new(0.5, 0.5)
        u50.Position = UDim2.new(0.5, 0, 0.5, 0)
        u50.Visible = false
        u50.Parent = u48
        local u55 = u48.Changed:Connect(function() --[[ Name: UpdateFrameSize, Line 233 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u50
            --]]
            local v51 = u48.AbsoluteSize
            local v52 = v51.X
            local v53 = v51.Y
            local v54 = math.min(v52, v53)
            math.abs(v54)
            u50.AdornFrame.Size = UDim2.new(1, 0, 1, 0)
        end)
        local v56 = u48.AbsoluteSize
        local v57 = v56.X
        local v58 = v56.Y
        local v59 = math.min(v57, v58)
        math.abs(v59)
        u50.AdornFrame.Size = UDim2.new(1, 0, 1, 0)
        local u60 = u50.Destroy
        local function v62(p61) --[[ Line: 245 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u55
            --]]
            u60(p61)
            if u55 then
                u55:Disconnect()
                u55 = nil
            end
        end
        rawset(u50, "Destroy", v62)
        u48.Destroying:Connect(function() --[[ Line: 255 ]]
            --[[
            Upvalues:
                [1] = u50
            --]]
            u50:End()
        end)
        return u50
    end
}
return u63