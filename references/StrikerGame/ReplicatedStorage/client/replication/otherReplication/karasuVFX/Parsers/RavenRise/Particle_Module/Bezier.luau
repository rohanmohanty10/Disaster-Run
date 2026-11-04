 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=7747728449

-- ! Source from the asset above; the game may have edited it since.

--[[
-- created by bhristt (october 15 2021)
-- bezier module for easy creation of bezier curves
-- updated (october 25 2021)
--!nocheck


-- types
export type BezierPoint = {
	Type: string;
	Point: Vector3 | BasePart;
}


-- bezier class
local Bezier = {}
Bezier.__index = Bezier


-- berenstein polynomial (used in position and derivative functions)
function B(n: number, i: number, t: number)

	-- factorial function
	local function fact(n: number): number
		if n == 0 then
			return 1
		else
			return n * fact(n - 1)
		end
	end

	-- return
	return (fact(n) / (fact(i) * fact(n - i))) * t^(i) * (1 - t)^(n - i)
end


-- the constructor
-- creates a new Bezier object with the given points added in order
function Bezier.new(...: Vector3 | BasePart)
	local self = setmetatable({}, Bezier)
	local args = {...}
	
	-- holds the points
	self.Points = {}
	
	-- length information
	self.LengthIterations = 1000
	self.LengthIndeces = {}
	self.Length = 0
	
	-- holds the connections from baseparts
	self._connections = {}
	
	-- iterate through given arguments
	for _, p in pairs(args) do
		if typeof(p) == "Vector3" or (typeof(p) == "Instance" and p:IsA("BasePart")) then
			self:AddBezierPoint(p)
		else
			error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!")
		end
	end
	
	-- returns the bezier object
	return self
end


-- adds a BezierPoint to the Bezier
-- a BezierPoint can either be a Vector3 or a BasePart
-- a Vector3 BezierPoint is static, while a BasePart BezierPoint changes if the BasePart's position changes
function Bezier:AddBezierPoint(p: Vector3 | BasePart, index: number?)
	
	-- check if given value is a Vector3 or BasePart
	if p and (typeof(p) == "Instance" and p:IsA("BasePart")) or typeof(p) == "Vector3" then
		local newPoint: BezierPoint = {
			Type = typeof(p) == "Vector3" and "StaicPoint" or "BasePartPoint";
			Point = p;
		}
		
		-- if point is a BasePartPoint, then watch for removal and changes
		if newPoint.Type == "BasePartPoint" then
			local connection, connection2
			
			-- changed connection
			connection = (p:: BasePart).Changed:Connect(function(prop)
				if prop == "Position" then
					self:UpdateLength()
				end
			end)
			
			-- deleted connection
			connection2 = (p:: BasePart).AncestryChanged:Connect(function(_, parent)
				if parent == nil then
					local index = table.find(self.Points, newPoint)
					if index then
						table.remove(self.Points, index)
					end
					connection:Disconnect()
					connection:Disconnect()
				end
			end)
			
			-- check if there is a connection table for the basepart
			if not self._connections[p] then
				self._connections[p] = {}
			end
			
			-- add connections to connection table
			table.insert(self._connections[p], connection)
			table.insert(self._connections[p], connection2)
		end
		
		-- add to list of points
		if index and type(index) == "number" then
			
			-- found index, add at index
			table.insert(self.Points, index, newPoint)
		elseif not index then
			
			-- did not find index, add to end of table
			table.insert(self.Points, newPoint)
		elseif type(index) ~= "number" then
			
			-- incorrect type
			error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
		end
		
		-- update bezier
		self:UpdateLength()
	else
		error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!")
	end
end


-- changes a BezierPoint in the Bezier
-- only works if the BezierPoint exists in the Bezier
function Bezier:ChangeBezierPoint(index: number, p: Vector3 | BasePart)
	
	-- check that index is a number
	if type(index) ~= "number" then
		error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!")
	end
	
	-- check if given value is a Vector3 or BasePart
	if p and (typeof(p) == "Instance" and p:IsA("BasePart")) or typeof(p) == "Vector3" then
		
		-- check if the bezier point exists
		local BezierPoint = self.Points[index]
		if BezierPoint then
			
			-- check type of point and add to bezier
			BezierPoint.Type = typeof(p) == "Vector3" and "StaicPoint" or "BasePartPoint";
			BezierPoint.Point = p
			
			-- update bezier
			self:UpdateLength()
		else
			
			-- bezier point does not exist
			error("Did not find BezierPoint at index " .. tostring(index))
		end
	else
		
		-- incorrect type
		error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!")
	end
end


-- returns a table with vector3 control points of the Bezier
function Bezier:GetAllPoints(): {Vector3}
	
	-- declarations
	local points = self.Points
	local numPoints = #points
	local v3Points = {}
	
	-- iterate through points
	for i = 1, numPoints do
		table.insert(v3Points, self:GetPoint(i))
	end
	
	-- return list of points
	return v3Points
end


-- gets the BezierPoint of the Bezier at the index
function Bezier:GetPoint(i: number): Vector3?

	-- checks for type
	local points = self.Points
	if points[i] then
		return typeof(points[i].Point) == "Vector3" and points[i].Point or points[i].Point.Position
	else
		error("Did not find a BezierPoint at index " .. tostring(i) .. "!")
	end
end


-- removes a BezierPoint from the Bezier
function Bezier:RemoveBezierPoint(index: number)
	
	-- check if the point exists
	if self.Points[index] then
		
		-- remove point and remove connections
		local point = table.remove(self.Points, index)
		if typeof(point.Point) == "Instance" and point.Point:IsA("BasePart") then
			for i, connection in pairs(self._connections[point.Point]) do
				if connection.Connected then
					connection:Disconnect()
				end
			end
			self._connections[point.Point] = nil
		end
		
		-- update bezier
		self:UpdateLength()
	end
end


-- updates length of the Bezier
function Bezier:UpdateLength()
	-- important values
	local points = self:GetAllPoints()
	local iterations = self.LengthIterations

	-- check if points is less than 2 (need at least 2 points to calculate length)
	if #points < 2 then
		return 0, {{0, 0, 0}, {0, 0, 0}}
	end

	-- start iteration
	local l = 0
	local sums = {}
	for i = 1, iterations do
		local dldt = self:CalculateDerivativeAt((i - 1) / (iterations - 1))
		l += dldt.Magnitude * (1 / iterations)
		table.insert(sums, {((i - 1) / (iterations - 1)), l, dldt})
	end

	-- return length and sum table
	self.Length, self.LengthIndeces = l, sums
end


-- returns the Vector3 point at the given t value (t must be between 0 and 1 to return an excpected value)
-- does not work if the bezier does not have any points attached to it
function Bezier:CalculatePositionAt(t: number): Vector3
	
	-- check if t is between 0 and 1
	if type(t) ~= "number" then
		error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(t) .. "!")
	end

	-- start algorithm to calculate position in bezier
	local points = self.Points
	local numPoints = #points
	
	-- check if there is at least 1 point
	if numPoints > 0 then
		
		-- important values
		local points = self:GetAllPoints()
		local n = #points
		
		-- get position at t
		local c_t do
			c_t = Vector3.new()
			for i = 1, n do
				local p_i = points[i]
				local B_nit = B(n - 1, i - 1, t)
				c_t += B_nit * p_i
			end
		end
		
		-- return position
		return c_t
	else
		
		-- not enough points to get position
		error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!")
	end
end


-- returns the Vector3 point at the given t value, where t is relative to the length of the Bezier curve
-- does not work if the bezier does not have any points attached to it
function Bezier:CalculatePositionRelativeToLength(t: number): Vector3
	
	-- check if t is a number between 0 and 1
	if type(t) ~= "number" then
		error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end
	
	-- start algorithm to calculate position in bezier
	local points = self.Points
	local numPoints = #points
	
	-- check if there is at least 1 point
	if numPoints > 0 then
		
		-- important values
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = self:GetAllPoints()
		
		-- check if there is more than 1 point
		if #points > 1 then
			
			-- get length of bezier
			local targetLength = length * t
			
			-- iterate through sum table
			local nearestParameterIndex, nearestParameter
			for i, orderedPair in ipairs(lengthIndeces) do
				if targetLength - orderedPair[2] <= 0 then
					nearestParameterIndex = i
					nearestParameter = orderedPair
					break
				elseif i == #lengthIndeces then
					nearestParameterIndex = i
					nearestParameter = orderedPair
					break
				end
			end
			
			-- calculate percent error
			local p0, p1
			if lengthIndeces[nearestParameterIndex - 1] then
				p0, p1 = self:CalculatePositionAt(lengthIndeces[nearestParameterIndex - 1][1]), self:CalculatePositionAt(nearestParameter[1])
			else
				p0, p1 = self:CalculatePositionAt(nearestParameter[1]), self:CalculatePositionAt(lengthIndeces[nearestParameterIndex + 1][1])
			end
			local percentError = (nearestParameter[2] - targetLength) / (p1 - p0).Magnitude
			
			-- return the position at the nearestParameter
			return p0 + (p1 - p0) * (1 - percentError)
		else
			
			-- return only position
			return self:CalculatePositionAt(0)
		end
	else
		
		-- not enough points to get a position
		error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!")
	end
end


-- returns the tangent vector in the direction of the path made by the bezier at t
-- in order to get a derivative of a Bezier, you need at least 2 points in the Bezier
function Bezier:CalculateDerivativeAt(t: number): Vector3?
	
	-- check if t is between 0 and 1
	if type(t) ~= "number" then
		error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(t) .. "!")
	end
	
	-- start algorithm to calculate bezier derivative
	local points = self.Points
	local numPoints = #points
	
	-- check if there are at least 2 points
	if numPoints > 1 then
		
		-- important values
		local points = self:GetAllPoints()
		local n = #points
		local m = n - 1
		
		-- calculate derivative at t
		local cPrime_t do
			cPrime_t = Vector3.new()
			for i = 1, n - 1 do
				local p_i1, p_i = points[i + 1], points[i]
				local Q_i = (n - 1) * (p_i1 - p_i)
				local B_mit = B(n - 2, i - 1, t)
				cPrime_t += B_mit * Q_i
			end
		end
		
		-- return derivative
		return cPrime_t
	else 
		
		-- not enough points
		error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!")
	end
end


-- returns the tangent vector in the direction of the path made by the bezier at t (where t is relative to the length of the Bezier Curve)
-- does not work if the bezier does not have at least 2 points
-- the given t value must be between 0 and 1
function Bezier:CalculateDerivativeRelativeToLength(t: number): Vector3
	
	-- check if t is a number between 0 and 1
	if type(t) ~= "number" then
		error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(t) .. "!")
	end
	
	-- start algorithm to calculate derivative in bezier
	local points = self.Points
	local numPoints = #points
	
	-- check if there are at least 2 points
	if numPoints > 1 then
		
		-- important values
		local length = self.Length
		local lengthIndeces = self.LengthIndeces
		local iterations = self.LengthIterations
		local points = self:GetAllPoints()

		-- get length of bezier
		local targetLength = length * t

		-- iterate through sum table
		local nearestParameterIndex, nearestParameter
		for i, orderedPair in ipairs(lengthIndeces) do
			if targetLength - orderedPair[2] <= 0 then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			elseif i == #lengthIndeces then
				nearestParameterIndex = i
				nearestParameter = orderedPair
				break
			end
		end

		-- calculate percent error
		local d0, d1
		if lengthIndeces[nearestParameterIndex - 1] then
			d0, d1 = self:CalculateDerivativeAt(lengthIndeces[nearestParameterIndex - 1][1]), self:CalculateDerivativeAt(nearestParameter[1])
		else
			d0, d1 = self:CalculateDerivativeAt(nearestParameter[1]), self:CalculateDerivativeAt(lengthIndeces[nearestParameterIndex + 1][1])
		end
		local percentError = (nearestParameter[2] - targetLength) / (d1 - d0).Magnitude

		-- return the derivative at the nearestParameter
		return d0 + (d1 - d0) * (1 - percentError)
	else
		
		-- not enough points to calculate derivative
		error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!")
	end
end


-- tweens a given object in the path made by the Bezier (position only)
-- works for any object that has the properties given by the property table
function Bezier:CreateVector3Tween(object: Instance | {[any]: any}, propertyTable: {any}, bezierTweenInfo: TweenInfo, RelativeToLength: boolean?): Tween
	
	-- check if there are enough points to calculate a position within the Bezier
	if #self.Points == 0 then
		error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!")
	end
	
	-- check if the object given is a valid object
	if typeof(object) ~= "Instance" and typeof(object) ~= "table" then
		error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!")
	end
	
	-- check if the bezierTweenInfo given is a TweenInfo object
	if not (typeof(bezierTweenInfo) == "TweenInfo") then
		error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!")
	end
	
	-- check if the object given has the vector3 properties given
	local success, foundProperties = pcall(function()
		local foundProperties = true
		for _, propertyName in pairs(propertyTable) do
			if typeof(object[propertyName]) ~= "Vector3" and typeof(object[propertyName]) ~= "nil" then
				foundProperties = false
				break
			end
		end
		return foundProperties
	end)
	
	-- check if the properties were found
	if success and foundProperties then
		local tweenService = game:GetService("TweenService")
		local numValue = Instance.new("NumberValue")
		local tween = tweenService:Create(numValue, bezierTweenInfo, {Value = 1})
		local numValueChangedConnection
		tween.Changed:Connect(function(prop)
			if prop == "PlaybackState" then
				local playbackState = tween.PlaybackState
				if playbackState == Enum.PlaybackState.Playing then
					numValueChangedConnection = numValue.Changed:Connect(function(t)
						for _, propName in pairs(propertyTable) do
							object[propName] = RelativeToLength and self:CalculatePositionRelativeToLength(t) or self:CalculatePositionAt(t)
						end
					end)
				else
					if numValueChangedConnection then
						numValueChangedConnection:Disconnect()
						numValueChangedConnection = nil
					end
				end
			end
		end)
		return tween
	else
		error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!")
	end
end


-- tweens a given object in the path made by the Bezier (cframe version)
-- works for any object that has the properties given by the property table
function Bezier:CreateCFrameTween(object: Instance | {[any]: any}, propertyTable: {any}, bezierTweenInfo: TweenInfo, RelativeToLength: boolean?): Tween
	
	-- check if there are enough points to calculate a cframe within the Bezier
	if #self.Points <= 1 then
		error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!")
	end

	-- check if the object given is a valid object
	if typeof(object) ~= "Instance" and typeof(object) ~= "table" then
		error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!")
	end

	-- check if the bezierTweenInfo given is a TweenInfo object
	if not (typeof(bezierTweenInfo) == "TweenInfo") then
		error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!")
	end

	-- check if the object given has the CFrame properties given
	local success, foundProperties = pcall(function()
		local foundProperties = true
		for _, propertyName in pairs(propertyTable) do
			if typeof(object[propertyName]) ~= "CFrame" and typeof(object[propertyName]) ~= "nil" then
				foundProperties = false
				break
			end
		end
		return foundProperties
	end)

	-- check if the properties were found
	if success and foundProperties then
		local tweenService = game:GetService("TweenService")
		local numValue = Instance.new("NumberValue")
		local tween = tweenService:Create(numValue, bezierTweenInfo, {Value = 1})
		local numValueChangedConnection
		tween.Changed:Connect(function(prop)
			if prop == "PlaybackState" then
				local playbackState = tween.PlaybackState
				if playbackState == Enum.PlaybackState.Playing then
					numValueChangedConnection = numValue.Changed:Connect(function(t)
						for _, propName in pairs(propertyTable) do
							local position = RelativeToLength and self:CalculatePositionRelativeToLength(t) or self:CalculatePositionAt(t)
							local derivative = RelativeToLength and self:CalculateDerivativeRelativeToLength(t) or self:CalculateDerivativeAt(t)
							object[propName] = CFrame.new(position, position + derivative)
						end
					end)
				else
					if numValueChangedConnection then
						numValueChangedConnection:Disconnect()
						numValueChangedConnection = nil
					end
				end
			end
		end)
		return tween
	else
		error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!")
	end
end


-- return
return Bezier
]]

 

local u1 = {};
u1.__index = u1;

function B(p2: number, p3: number, p4: number)
    local function fact(p5: number) -- Line: 23
        -- upvalues: fact (copy)
        return p5 == 0 and 1 or p5 * fact(p5 - 1);
    end;

    local v6 = p2 == 0 and 1 or p2 * fact(p2 - 1);
    local v7 = p3 == 0 and 1 or p3 * fact(p3 - 1);
    local v8 = p2 - p3;

    return v6 / (v7 * (v8 == 0 and 1 or v8 * fact(v8 - 1))) * p4 ^ p3 * (1 - p4) ^ (p2 - p3);
end;

function u1.new(...) -- Line: 38
    -- upvalues: u1 (copy)
    local v9 = setmetatable({}, u1);
    v9.Points = {};
    v9.LengthIterations = 1000;
    v9.LengthIndeces = {};
    v9.Length = 0;
    v9._connections = {};

    for _, v in pairs({ ... }) do
        if typeof(v) == "Vector3" or typeof(v) == "Instance" and v:IsA("BasePart") then
            v9:AddBezierPoint(v);
        else
            print((typeof(v)));
            error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!");
        end;
    end;

    return v9;
end;

function u1.AddBezierPoint(u10: table, p11: any, p12: number?) -- Line: 71
    if not (p11 and (typeof(p11) == "Instance" and p11:IsA("BasePart"))) and typeof(p11) ~= "Vector3" then
        error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!");

        return;
    end;

    local u13 = {
        Type = typeof(p11) == "Vector3" and "StaicPoint" or "BasePartPoint",
        Point = p11
    };

    if u13.Type == "BasePartPoint" then
        local u15 = p11.Changed:Connect(function(p14) -- Line: 85
            -- upvalues: u10 (copy)
            if p14 == "Position" then
                u10:UpdateLength();
            end;
        end);
        local v18 = p11.AncestryChanged:Connect(function(p16, p17) -- Line: 92
            -- upvalues: u10 (copy), u13 (copy), u15 (ref)
            if p17 == nil then
                local table_find_ret = table.find(u10.Points, u13);

                if table_find_ret then
                    table.remove(u10.Points, table_find_ret);
                end;

                u15:Disconnect();
                u15:Disconnect();
            end;
        end);

        if not u10._connections[p11] then
            u10._connections[p11] = {};
        end;

        table.insert(u10._connections[p11], u15);
        table.insert(u10._connections[p11], v18);
    end;

    if p12 and type(p12) == "number" then
        table.insert(u10.Points, p12, u13);
    elseif p12 then
        if type(p12) ~= "number" then
            error("Bezier:AddBezierPoint() only accepts an integer as the second argument!");
        end;
    else
        table.insert(u10.Points, u13);
    end;

    u10:UpdateLength();
end;

function u1.ChangeBezierPoint(p19: table, p20: number, p21: any) -- Line: 138
    if type(p20) ~= "number" then
        error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!");
    end;

    if not (p21 and (typeof(p21) == "Instance" and p21:IsA("BasePart"))) and typeof(p21) ~= "Vector3" then
        error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!");

        return;
    end;

    local v22 = p19.Points[p20];

    if not v22 then
        error("Did not find BezierPoint at index " .. tostring(p20));

        return;
    end;

    v22.Type = typeof(p21) == "Vector3" and "StaicPoint" or "BasePartPoint";
    v22.Point = p21;
    p19:UpdateLength();
end;

function u1.GetAllPoints(p23) -- Line: 172
    local v24 = {};

    for i = 1, #p23.Points do
        table.insert(v24, p23:GetPoint(i));
        local _ = i;
    end;

    return v24;
end;

function u1.GetPoint(p25: table, p26: number) -- Line: 190
    local Points = p25.Points;

    if Points[p26] then
        return typeof(Points[p26].Point) == "Vector3" and Points[p26].Point or Points[p26].Point.Position;
    end;

    error("Did not find a BezierPoint at index " .. tostring(p26) .. "!");
end;

function u1.RemoveBezierPoint(p27: table, p28: number) -- Line: 203
    if p27.Points[p28] then
        local table_remove_ret = table.remove(p27.Points, p28);

        if typeof(table_remove_ret.Point) == "Instance" and table_remove_ret.Point:IsA("BasePart") then
            for _, v in pairs(p27._connections[table_remove_ret.Point]) do
                if v.Connected then
                    v:Disconnect();
                end;
            end;

            p27._connections[table_remove_ret.Point] = nil;
        end;

        p27:UpdateLength();
    end;
end;

function u1.UpdateLength(p29) -- Line: 226
    local AllPoints = p29:GetAllPoints();
    local LengthIterations = p29.LengthIterations;

    if #AllPoints < 2 then
        return 0, { { 0, 0, 0 }, { 0, 0, 0 } };
    end;

    local v30 = 0;
    local v31 = {};

    for i = 1, LengthIterations do
        local v32 = p29:CalculateDerivativeAt((i - 1) / (LengthIterations - 1));
        v30 = v30 + v32.Magnitude * (1 / LengthIterations);
        table.insert(v31, { (i - 1) / (LengthIterations - 1), v30, v32 });
        local _ = i;
    end;

    p29.Length = v30;
    p29.LengthIndeces = v31;
end;

function u1.CalculatePositionAt(p33: table, p34: number) -- Line: 252
    if type(p34) ~= "number" then
        error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(p34) .. "!");
    end;

    if #p33.Points > 0 then
        local AllPoints = p33:GetAllPoints();
        local v35 = #AllPoints;
        local Vector3_new_ret = Vector3.new();

        for i = 1, v35 do
            local v36 = AllPoints[i];
            Vector3_new_ret = Vector3_new_ret + B(v35 - 1, i - 1, p34) * v36;
            local _ = i;
        end;

        return Vector3_new_ret;
    end;

    error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!");
end;

function u1.CalculatePositionRelativeToLength(p37: table, p38: number) -- Line: 292
    if type(p38) ~= "number" then
        error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p38) .. "!");
    end;

    if #p37.Points <= 0 then
        error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!");

        return;
    end;

    local Length = p37.Length;
    local LengthIndeces = p37.LengthIndeces;
    local _ = p37.LengthIterations;

    if #p37:GetAllPoints() <= 1 then
        return p37:CalculatePositionAt(0);
    end;

    local v39 = Length * p38;
    local v40 = nil;
    local v41 = nil;

    for i, v in ipairs(LengthIndeces) do
        if v39 - v[2] <= 0 or i == #LengthIndeces then
            v41 = v;
            v40 = i;
            break;
        end;
    end;

    local v42, v43;

    if LengthIndeces[v40 - 1] then
        v42 = p37:CalculatePositionAt(LengthIndeces[v40 - 1][1]);
        v43 = p37:CalculatePositionAt(v41[1]);
    else
        v42 = p37:CalculatePositionAt(v41[1]);
        v43 = p37:CalculatePositionAt(LengthIndeces[v40 + 1][1]);
    end;

    return v42 + (v43 - v42) * (1 - (v41[2] - v39) / (v43 - v42).Magnitude);
end;

function u1.CalculateDerivativeAt(p44: table, p45: number) -- Line: 358
    if type(p45) ~= "number" then
        error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(p45) .. "!");
    end;

    if #p44.Points > 1 then
        local AllPoints = p44:GetAllPoints();
        local v46 = #AllPoints;
        local _ = v46 - 1;
        local Vector3_new_ret = Vector3.new();

        for i = 1, v46 - 1 do
            local v47 = (v46 - 1) * (AllPoints[i + 1] - AllPoints[i]);
            Vector3_new_ret = Vector3_new_ret + B(v46 - 2, i - 1, p45) * v47;
            local _ = i;
        end;

        return Vector3_new_ret;
    end;

    error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!");
end;

function u1.CalculateDerivativeRelativeToLength(p48: table, p49: number) -- Line: 401
    if type(p49) ~= "number" then
        error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p49) .. "!");
    end;

    if #p48.Points <= 1 then
        error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!");

        return;
    end;

    local Length = p48.Length;
    local LengthIndeces = p48.LengthIndeces;
    local _ = p48.LengthIterations;
    p48:GetAllPoints();
    local v50 = Length * p49;
    local v51 = nil;
    local v52 = nil;

    for i, v in ipairs(LengthIndeces) do
        if v50 - v[2] <= 0 or i == #LengthIndeces then
            v52 = v;
            v51 = i;
            break;
        end;
    end;

    local v53, v54;

    if LengthIndeces[v51 - 1] then
        v53 = p48:CalculateDerivativeAt(LengthIndeces[v51 - 1][1]);
        v54 = p48:CalculateDerivativeAt(v52[1]);
    else
        v53 = p48:CalculateDerivativeAt(v52[1]);
        v54 = p48:CalculateDerivativeAt(LengthIndeces[v51 + 1][1]);
    end;

    return v53 + (v54 - v53) * (1 - (v52[2] - v50) / (v54 - v53).Magnitude);
end;

function u1.CreateVector3Tween(u55: table, u56: any, u57: table, p58: userdata, u59: boolean?) -- Line: 459
    if #u55.Points == 0 then
        error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!");
    end;

    if typeof(u56) ~= "Instance" and typeof(u56) ~= "table" then
        error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!");
    end;

    if typeof(p58) ~= "TweenInfo" then
        error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!");
    end;

    local success, result = pcall(function() -- Line: 477
        -- upvalues: u57 (copy), u56 (copy)
        for _, v in pairs(u57) do
            if typeof(u56[v]) ~= "Vector3" and typeof(u56[v]) ~= "nil" then
                return false;
            end;
        end;

        return true;
    end);

    if success and result then
        local TweenService = game:GetService("TweenService");
        local NumberValue = Instance.new("NumberValue");
        local u60 = TweenService:Create(NumberValue, p58, {
            Value = 1
        });
        local u61 = nil;
        u60.Changed:Connect(function(p62) -- Line: 494
            -- upvalues: u60 (copy), u61 (ref), NumberValue (copy), u57 (copy), u56 (copy), u59 (copy), u55 (copy)
            if p62 == "PlaybackState" then
                if u60.PlaybackState == Enum.PlaybackState.Playing then
                    u61 = NumberValue.Changed:Connect(function(p63) -- Line: 498
                        -- upvalues: u57 (ref), u56 (ref), u59 (ref), u55 (ref)
                        for _, v in pairs(u57) do
                            u56[v] = u59 and u55:CalculatePositionRelativeToLength(p63) or u55:CalculatePositionAt(p63);
                        end;
                    end);

                    return;
                end;

                if u61 then
                    u61:Disconnect();
                    u61 = nil;
                end;
            end;
        end);

        return u60;
    end;

    error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!");
end;

function u1.CreateCFrameTween(u64: table, u65: any, u66: table, p67: userdata, u68: boolean?, u69) -- Line: 520
    if #u64.Points <= 1 then
        error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!");
    end;

    if typeof(u65) ~= "Instance" and typeof(u65) ~= "table" then
        error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!");
    end;

    if typeof(p67) ~= "TweenInfo" then
        error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!");
    end;

    if u69 == nil then
        u69 = CFrame.Angles(0, 0, 0);
    end;

    local success, result = pcall(function() -- Line: 542
        -- upvalues: u66 (copy), u65 (copy)
        for _, v in pairs(u66) do
            if typeof(u65[v]) ~= "CFrame" and typeof(u65[v]) ~= "nil" then
                return false;
            end;
        end;

        return true;
    end);

    if success and result then
        local TweenService = game:GetService("TweenService");
        local NumberValue = Instance.new("NumberValue");
        local u70 = TweenService:Create(NumberValue, p67, {
            Value = 1
        });
        local u71 = nil;
        u70.Changed:Connect(function(p72) -- Line: 559
            -- upvalues: u70 (copy), u71 (ref), NumberValue (copy), u66 (copy), u68 (copy), u64 (copy), u65 (copy), u69 (ref)
            if p72 == "PlaybackState" then
                if u70.PlaybackState == Enum.PlaybackState.Playing then
                    u71 = NumberValue.Changed:Connect(function(p73) -- Line: 563
                        -- upvalues: u66 (ref), u68 (ref), u64 (ref), u65 (ref), u69 (ref)
                        for _, v in pairs(u66) do
                            local v74 = u68 and u64:CalculatePositionRelativeToLength(p73) or u64:CalculatePositionAt(p73);
                            local v75 = u68 and u64:CalculateDerivativeRelativeToLength(p73) or u64:CalculateDerivativeAt(p73);
                            u65[v] = CFrame.new(v74, v74 + v75) * u69;
                        end;
                    end);

                    return;
                end;

                if u71 then
                    u71:Disconnect();
                    u71 = nil;
                end;
            end;
        end);

        return u70;
    end;

    error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!");
end;

return u1;