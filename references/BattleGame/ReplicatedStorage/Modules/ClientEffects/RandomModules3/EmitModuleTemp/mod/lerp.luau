 
  
local v1 = require("./color/Oklab")
local t = {
	number = function(p1, p2, p3) --[[ number | Line: 7 ]]
		return p1 + (p2 - p1) * p3
	end,
	Vector3 = function(p1, p2, p3) --[[ Vector3 | Line: 11 ]]
		return p1:Lerp(p2, p3)
	end,
	Vector2 = function(p1, p2, p3) --[[ Vector2 | Line: 15 ]]
		return p1:Lerp(p2, p3)
	end,
	CFrame = function(p1, p2, p3) --[[ CFrame | Line: 19 ]]
		return p1:Lerp(p2, p3)
	end,
	UDim2 = function(p1, p2, p3) --[[ UDim2 | Line: 23 ]]
		return p1:Lerp(p2, p3)
	end
}
function t.UDim(p1, p2, p3) --[[ UDim | Line: 27 | Upvalues: t (copy) ]]
	return UDim.new(t.number(p1.Scale, p2.Scale, p3), t.number(p1.Offset, p2.Offset, p3))
end
function t.NumberRange(p1, p2, p3) --[[ NumberRange | Line: 35 | Upvalues: t (copy) ]]
	return NumberRange.new(t.number(p1.Min, p2.Min, p3), t.number(p1.Max, p2.Max, p3))
end
function t.Color3(p1, p2, p3) --[[ Color3 | Line: 43 | Upvalues: v1 (copy) ]]
	return v1.toSRGB(v1.fromSRGB(p1):Lerp(v1.fromSRGB(p2), p3))
end
function t.PhysicalProperties(p1, p2, p3) --[[ PhysicalProperties | Line: 50 | Upvalues: t (copy) ]]
	return PhysicalProperties.new(t.number(p1.Density, p2.Density, p3), t.number(p1.Friction, p2.Friction, p3), t.number(p1.Elasticity, p2.Elasticity, p3), t.number(p1.FrictionWeight, p2.FrictionWeight, p3), t.number(p1.ElasticityWeight, p2.ElasticityWeight, p3))
end
function t.Rect(p1, p2, p3) --[[ Rect | Line: 60 ]]
	return Rect.new(p1.Min:Lerp(p2.Min, p3), p1.Max:Lerp(p2.Max, p3))
end
function t.NumberSequence(p1, p2, p3) --[[ NumberSequence | Line: 65 ]]
	local count = 0
	local t = {}
	local t2 = {}
	for v3, v4 in p1.Keypoints do
		local v1, v2
		local v5 = nil
		local v6 = nil
		for v7, v8 in p2.Keypoints do
			if v8.Time == v4.Time then
				v5 = v8
				v6 = v8
				break
			end
			if v8.Time < v4.Time and (v6 == nil or v8.Time > v6.Time) then
				v6 = v8
				continue
			end
			if v8.Time > v4.Time and (v5 == nil or v8.Time < v5.Time) then
				v5 = v8
			end
		end
		if v5 == v6 then
			v1 = v5.Value
			v2 = v5.Envelope
		else
			local v9 = (v4.Time - v6.Time) / (v5.Time - v6.Time)
			v1 = (v5.Value - v6.Value) * v9 + v6.Value
			v2 = (v5.Envelope - v6.Envelope) * v9 + v6.Envelope
		end
		count = count + 1
		t[count] = NumberSequenceKeypoint.new(v4.Time, (v1 - v4.Value) * p3 + v4.Value, (v2 - v4.Envelope) * p3 + v4.Envelope)
		t2[v4.Time] = true
	end
	for v12, v13 in p2.Keypoints do
		local v10, v11
		if not t2[v13.Time] then
			local v14 = nil
			local v15 = nil
			for v16, v17 in p1.Keypoints do
				if v17.Time == v13.Time then
					v14 = v17
					v15 = v17
					break
				end
				if v17.Time < v13.Time and (v15 == nil or v17.Time > v15.Time) then
					v15 = v17
					continue
				end
				if v17.Time > v13.Time and (v14 == nil or v17.Time < v14.Time) then
					v14 = v17
				end
			end
			if v14 == v15 then
				v10 = v14.Value
				v11 = v14.Envelope
			else
				local v18 = (v13.Time - v15.Time) / (v14.Time - v15.Time)
				v10 = (v14.Value - v15.Value) * v18 + v15.Value
				v11 = (v14.Envelope - v15.Envelope) * v18 + v15.Envelope
			end
			count = count + 1
			t[count] = NumberSequenceKeypoint.new(v13.Time, (v13.Value - v10) * p3 + v10, (v13.Envelope - v11) * p3 + v11)
		end
	end
	table.sort(t, function(p1, p2) --[[ Line: 136 ]]
		return p1.Time < p2.Time
	end)
	local v19
	if #t > 20 then
		local v20 = (#t - 1) / 19
		v19 = {}
		for i = 0, 19 do
			table.insert(v19, t[math.floor(i * v20 + 1)])
		end
		if v19[#v19].Time < t[#t].Time then
			v19[#v19] = t[#t]
		end
	else
		v19 = t
	end
	return NumberSequence.new(v19)
end
local function getColorAtTime(p1, p2) --[[ getColorAtTime | Line: 161 ]]
	local Keypoints = p1.Keypoints
	if p2 <= Keypoints[1].Time then
		return Keypoints[1].Value
	end
	if Keypoints[#Keypoints].Time <= p2 then
		return Keypoints[#Keypoints].Value
	end
	local v1 = nil
	local v2 = nil
	for i = 1, #Keypoints do
		local v3 = Keypoints[i]
		if v3.Time == p2 then
			return v3.Value
		end
		if v3.Time < p2 then
			v1 = v3
			continue
		end
		if p2 < v3.Time then
			v2 = v3
			break
		end
	end
	return v1.Value:Lerp(v2.Value, (p2 - v1.Time) / (v2.Time - v1.Time))
end
function t.ColorSequence(p1, p2, p3) --[[ ColorSequence | Line: 192 | Upvalues: getColorAtTime (copy) ]]
	local t = {}
	for i, v in ipairs(p2.Keypoints) do
		local v1 = getColorAtTime(p1, v.Time):Lerp(v.Value, p3)
		local v2 = ColorSequenceKeypoint.new
		table.insert(t, v2(v.Time, v1))
	end
	return ColorSequence.new(t)
end
function t.Other(p1, p2, p3) --[[ Other | Line: 209 ]]
	return if p3 < 0.5 then if p1 then p1 else p2 else p2
end
return t