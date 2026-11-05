 
  
local function cubicBezier(p1, p2, p3, p4, p5) --[[ cubicBezier | Line: 6 ]]
	return (1 - p5) ^ 3 * p1 + 3 * (1 - p5) ^ 2 * p5 * p2 + 3 * (1 - p5) * p5 ^ 2 * p3 + p5 ^ 3 * p4
end
local function cubicBezierDerivative(p1, p2, p3, p4, p5) --[[ cubicBezierDerivative | Line: 11 ]]
	return 3 * (1 - p5) ^ 2 * (p2 - p1) + 6 * (1 - p5) * p5 * (p3 - p2) + 3 * p5 ^ 2 * (p4 - p3)
end
local t = {}
t.__index = t
function t.new(p1, p2) --[[ new | Line: 28 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	v2.points = p1
	v2.accuracy = p2 or 20
	v2.point_count = 0
	v2.cumulative_lengths = {}
	v2:_recalculate()
	return v2
end
function t.setPoints(p1, p2) --[[ setPoints | Line: 42 ]]
	p1.points = p2
	p1:_recalculate()
end
function t.getSegmentPoints(p1, p2) --[[ getSegmentPoints | Line: 47 ]]
	if p2 < 1 or p1.point_count - 1 < p2 then
		if p2 <= 0 then
			return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
		end
		error("attempt to get a non-existent segment at index " .. p2)
	end
	local v2 = math.max((p2 - 1) * 4 - math.max(p2 - 2, 0), 1)
	return p1.points[v2], p1.points[v2 + 1], p1.points[v2 + 2], p1.points[v2 + 3]
end
function t.forSample(p1, p2, p3) --[[ forSample | Line: 67 ]]
	local v1 = p1.length // p2
	if v1 == 0 then
		return
	end
	for i = 0, v1 do
		p3(p1:getPositionArcSpace(i / v1), i)
	end
end
function t.getPosition(p1, p2) --[[ getPosition | Line: 80 ]]
	local v1, v2 = p1:getSegmentIndex(p2)
	local v3, v4, v5, v6 = p1:getSegmentPoints(v1)
	return (1 - v2) ^ 3 * v3 + 3 * (1 - v2) ^ 2 * v2 * v4 + 3 * (1 - v2) * v2 ^ 2 * v5 + v2 ^ 3 * v6
end
function t.getSegmentIndex(p1, p2) --[[ getSegmentIndex | Line: 87 ]]
	local v1 = math.clamp(p2, 0, 1)
	local v2 = p1.point_count - 1
	local v3 = v1 * v2
	local v5 = math.min(math.floor(v3) + 1, v2)
	local v6 = v3 - math.floor(v3)
	if v1 == 1 then
		v6 = 1
	end
	return v5, v6
end
function t.getEasedSegmentIndex(p1, p2) --[[ getEasedSegmentIndex | Line: 104 ]]
	local v1 = p1.point_count - 1
	for i = 1, v1 do
		local v3, _, _2, v4 = p1:getSegmentPoints(i)
		local x = v3.x
		local x_2 = v4.x
		if x <= p2 and p2 < x_2 then
			return i, (p2 - x) / (x_2 - x)
		end
	end
	return v1, 1
end
function t.getEase(p1, p2) --[[ getEase | Line: 125 ]]
	local v1, sum = p1:getEasedSegmentIndex(p2)
	local v2, v3, v4, v5 = p1:getSegmentPoints(v1)
	for i = 1, 5 do
		local x_2 = v3.x
		local x_3 = v4.x
		local v7 = 3 * (1 - sum) ^ 2 * (x_2 - v2.x) + 6 * (1 - sum) * sum * (x_3 - x_2) + 3 * sum ^ 2 * (v5.x - x_3)
		if v7 == 0 then
			break
		end
		local v8 = ((1 - sum) ^ 3 * v2.x + 3 * (1 - sum) ^ 2 * sum * v3.x + 3 * (1 - sum) * sum ^ 2 * v4.x + sum ^ 3 * v5.x - p2) / v7
		sum = sum - v8
		if sum < 0 then
			sum = 0
		elseif sum > 1 then
			sum = 1
		end
		if math.abs(v8) < 0.001 then
			break
		end
	end
	return (1 - sum) ^ 3 * v2 + 3 * (1 - sum) ^ 2 * sum * v3 + 3 * (1 - sum) * sum ^ 2 * v4 + sum ^ 3 * v5
end
function t.getPositionArcSpace(p1, p2) --[[ getPositionArcSpace | Line: 154 ]]
	if p1.length <= 0 then
		return p1.points[1] or Vector3.new(0, 0, 0)
	end
	local v1 = math.clamp(p2, 0, 1) * p1.cumulative_lengths[p1.accuracy + 1]
	local v2 = p1.accuracy + 1
	local v3 = 1
	local count = nil
	while v3 < v2 do
		count = v3 + (v2 - v3) // 2
		if p1.cumulative_lengths[count] < v1 then
			v3 = count + 1
		else
			v2 = count
		end
	end
	if v1 < p1.cumulative_lengths[count] and count > 1 then
		count = count - 1
	end
	local v4 = p1.cumulative_lengths[count]
	if v4 == v1 then
		return p1:getPosition((count - 1) / p1.accuracy)
	else
		return p1:getPosition((count - 1 + (v1 - v4) / (p1.cumulative_lengths[count + 1] - v4)) / p1.accuracy)
	end
end
function t._recalculate(p1) --[[ _recalculate | Line: 190 ]]
	table.clear(p1.cumulative_lengths)
	table.insert(p1.cumulative_lengths, 0)
	p1.point_count = math.ceil(#p1.points / 3)
	local v2 = nil
	local sum = 0
	for i = 1, p1.accuracy do
		local v3 = p1:getPosition(i / p1.accuracy)
		if not v2 then
			v2 = p1:getPosition(0)
		end
		sum = sum + vector.magnitude(v3 - v2)
		table.insert(p1.cumulative_lengths, sum)
		v2 = v3
	end
	p1.length = sum
	for v5, v6 in p1.cumulative_lengths do
		p1.cumulative_lengths[v5] = v6 / sum
	end
end
return t