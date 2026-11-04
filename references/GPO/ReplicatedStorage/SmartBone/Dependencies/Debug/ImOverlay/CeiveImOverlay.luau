 

local u1 = game:GetService("GuiService")
local u2 = Font.new("rbxasset://fonts/families/PressStart2P.json")
local u3 = {}
u3.__index = u3
function u3.new(p4, p5, p6) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v7 = p6 == nil and true or p6
    local v8 = UDim2.fromOffset(25, 5 + u1:GetGuiInset().Y)
    local v9 = UDim2.new(1, -25, 1, -5)
    local v10 = UDim2.fromOffset(0, 0)
    local v11 = UDim2.fromScale(1, 1)
    local v12 = u3
    local v13 = setmetatable({}, v12)
    v13.DefaultY = p4 or 5
    v13.TextSize = p5 or 11
    v13.BackFrame = Instance.new("Frame")
    local v14 = v13.BackFrame
    if v7 then
        v10 = v8 or v10
    end
    v14.Position = v10
    local v15 = v13.BackFrame
    if v7 then
        v11 = v9 or v11
    end
    v15.Size = v11
    v13.BackFrame.Name = "BackFrame"
    v13.BackFrame.Transparency = 1
    v13.ListLayout = Instance.new("UIListLayout")
    v13.ListLayout.Padding = UDim.new(0, 2)
    v13.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    v13.ListLayout.Parent = v13.BackFrame
    v13.m_Indent = 0
    v13.DidUpdate = false
    v13.m_State = ""
    v13.m_PreviousState = ""
    v13.m_RenderGroup = {}
    v13.m_ItemPool = {}
    return v13
end
function u3.Begin(p16, p17, p18, p19) --[[ Line: 64 ]]
    if p17 and type(p17) == "string" then
        if p18 and typeof(p18) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback())
            return
        elseif p19 and typeof(p19) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback())
        else
            p16:Text(p17, p18, p19)
            p16.m_Indent = p16.m_Indent + 1
        end
    else
        warn("Expected text to ImOverlay::Begin", debug.traceback())
        return
    end
end
function u3.End(p20) --[[ Line: 84 ]]
    if p20.m_Indent - 1 < 0 then
        error("Too many callbacks to ImOverlay::End")
    else
        p20.m_Indent = p20.m_Indent - 1
    end
end
function u3.Text(p21, p22, p23, p24) --[[ Line: 93 ]]
    if p22 and type(p22) == "string" then
        if p23 and typeof(p23) ~= "Color3" then
            warn("BackgroundColor should be a Color3", debug.traceback())
            return
        elseif p24 and typeof(p24) ~= "Color3" then
            warn("TextColor should be a Color3", debug.traceback())
        else
            local v25 = p23 or Color3.new()
            local v26 = p24 or Color3.new(1, 1, 1)
            local v27 = p21.m_RenderGroup
            local v28 = {
                ["Text"] = p22,
                ["TextColor"] = v26,
                ["BackgroundColor"] = v25,
                ["Indent"] = p21.m_Indent
            }
            table.insert(v27, v28)
            p21.m_State = p21.m_State .. ("%*|%*|%*|%*"):format(p22, v26, v25, p21.m_Indent)
        end
    else
        warn("Expected text to ImOverlay::Text", debug.traceback())
        return
    end
end
function u3.m_Pool(p29) --[[ Line: 122 ]]
    for _, v30 in p29.BackFrame:GetChildren() do
        if not v30:IsA("UIListLayout") and v30.Visible then
            v30.Visible = false
            local v31 = p29.m_ItemPool
            table.insert(v31, v30)
        end
    end
end
function u3.m_Cleanup(p32) --[[ Line: 137 ]]
    p32.m_State = ""
    p32.m_Indent = 0
    p32.m_RenderGroup = {}
end
function u3.m_CreateLabel(p33, p34, p35, p36, p37) --[[ Line: 145 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v38 = Instance.new("Frame")
    v38.Name = "Background"
    v38.AutomaticSize = Enum.AutomaticSize.XY
    v38.BackgroundColor3 = p36
    v38.BackgroundTransparency = 0.4
    v38.BorderSizePixel = 0
    local v39 = Instance.new("TextLabel")
    v39.Name = "TaskText"
    v39.FontFace = u2
    v39.Text = p34
    v39.TextColor3 = p35
    v39.TextSize = p33.TextSize
    v39.TextXAlignment = Enum.TextXAlignment.Left
    v39.AutomaticSize = Enum.AutomaticSize.XY
    v39.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v39.BackgroundTransparency = 1
    v39.Position = UDim2.fromOffset(p37 * 50, 0)
    v39.Size = UDim2.fromOffset(0, p33.DefaultY)
    v39.Parent = v38
    local v40 = Instance.new("UIPadding")
    v40.Name = "UIPadding"
    v40.PaddingBottom = UDim.new(0, 2)
    v40.Parent = v39
    local v41 = Instance.new("UIPadding")
    v41.Name = "UIPadding"
    v41.PaddingRight = UDim.new(0, 5)
    v41.PaddingLeft = UDim.new(0, 5)
    v41.Parent = v38
    return v38
end
function u3.Render(p42) --[[ Line: 182 ]]
    if p42.m_State == "" then
        p42:m_Pool()
        p42:m_Cleanup()
        p42.DidUpdate = false
        return
    else
        p42.m_State = p42.m_State .. ("%*|%*"):format(p42.DefaultY, p42.TextSize)
        if p42.m_State == p42.m_PreviousState then
            p42:m_Cleanup()
            p42.DidUpdate = false
        else
            p42:m_Pool()
            p42.m_PreviousState = p42.m_State
            p42.DidUpdate = true
            for v43, v44 in p42.m_RenderGroup do
                if #p42.m_ItemPool == 0 then
                    local v45 = p42:m_CreateLabel(v44.Text, v44.TextColor, v44.BackgroundColor, v44.Indent)
                    v45.LayoutOrder = v43
                    v45.Parent = p42.BackFrame
                else
                    local v46 = table.remove(p42.m_ItemPool, #p42.m_ItemPool)
                    local v47 = v46.TaskText
                    v46.LayoutOrder = v43
                    v46.BackgroundColor3 = v44.BackgroundColor
                    v47.Text = v44.Text
                    v47.TextColor3 = v44.TextColor
                    v47.Position = UDim2.fromOffset(50 * v44.Indent, 0)
                    v46.Visible = true
                    v46.Parent = p42.BackFrame
                end
            end
            p42:m_Cleanup()
        end
    end
end
function u3.Destroy(p48) --[[ Line: 239 ]]
    p48.BackFrame:Destroy()
    setmetatable(p48, nil)
end
return u3