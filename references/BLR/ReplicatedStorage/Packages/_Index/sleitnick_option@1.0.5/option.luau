 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Option
-- Stephen Leitnick
-- August 28, 2020

--[[

	MatchTable {
		Some: (value: any) -> any
		None: () -> any
	}

	CONSTRUCTORS:

		Option.Some(anyNonNilValue): Option<any>
		Option.Wrap(anyValue): Option<any>


	STATIC FIELDS:

		Option.None: Option<None>


	STATIC METHODS:

		Option.Is(obj): boolean


	METHODS:

		opt:Match(): (matches: MatchTable) -> any
		opt:IsSome(): boolean
		opt:IsNone(): boolean
		opt:Unwrap(): any
		opt:Expect(errMsg: string): any
		opt:ExpectNone(errMsg: string): void
		opt:UnwrapOr(default: any): any
		opt:UnwrapOrElse(default: () -> any): any
		opt:And(opt2: Option<any>): Option<any>
		opt:AndThen(predicate: (unwrapped: any) -> Option<any>): Option<any>
		opt:Or(opt2: Option<any>): Option<any>
		opt:OrElse(orElseFunc: () -> Option<any>): Option<any>
		opt:XOr(opt2: Option<any>): Option<any>
		opt:Contains(value: any): boolean

	--------------------------------------------------------------------

	Options are useful for handling nil-value cases. Any time that an
	operation might return nil, it is useful to instead return an
	Option, which will indicate that the value might be nil, and should
	be explicitly checked before using the value. This will help
	prevent common bugs caused by nil values that can fail silently.


	Example:

	local result1 = Option.Some(32)
	local result2 = Option.Some(nil)
	local result3 = Option.Some("Hi")
	local result4 = Option.Some(nil)
	local result5 = Option.None

	-- Use 'Match' to match if the value is Some or None:
	result1:Match {
		Some = function(value) print(value) end;
		None = function() print("No value") end;
	}

	-- Raw check:
	if result2:IsSome() then
		local value = result2:Unwrap() -- Explicitly call Unwrap
		print("Value of result2:", value)
	end

	if result3:IsNone() then
		print("No result for result3")
	end

	-- Bad, will throw error bc result4 is none:
	local value = result4:Unwrap()

--]]

export type MatchTable<T> = {
	Some: (value: T) -> any,
	None: () -> any,
}

export type MatchFn<T> = (matches: MatchTable<T>) -> any

export type DefaultFn<T> = () -> T

export type AndThenFn<T> = (value: T) -> Option<T>

export type OrElseFn<T> = () -> Option<T>

export type Option<T> = typeof(setmetatable(
	{} :: {
		Match: (self: Option<T>) -> MatchFn<T>,
		IsSome: (self: Option<T>) -> boolean,
		IsNone: (self: Option<T>) -> boolean,
		Contains: (self: Option<T>, value: T) -> boolean,
		Unwrap: (self: Option<T>) -> T,
		Expect: (self: Option<T>, errMsg: string) -> T,
		ExpectNone: (self: Option<T>, errMsg: string) -> nil,
		UnwrapOr: (self: Option<T>, default: T) -> T,
		UnwrapOrElse: (self: Option<T>, defaultFn: DefaultFn<T>) -> T,
		And: (self: Option<T>, opt2: Option<T>) -> Option<T>,
		AndThen: (self: Option<T>, predicate: AndThenFn<T>) -> Option<T>,
		Or: (self: Option<T>, opt2: Option<T>) -> Option<T>,
		OrElse: (self: Option<T>, orElseFunc: OrElseFn<T>) -> Option<T>,
		XOr: (self: Option<T>, opt2: Option<T>) -> Option<T>,
	},
	{} :: {
		__index: Option<T>,
	}
))

local CLASSNAME = "Option"

--[=[
	@class Option

	Represents an optional value in Lua. This is useful to avoid `nil` bugs, which can
	go silently undetected within code and cause hidden or hard-to-find bugs.
]=]
local Option = {}
Option.__index = Option

function Option._new(value)
	local self = setmetatable({
		ClassName = CLASSNAME,
		_v = value,
		_s = (value ~= nil),
	}, Option)
	return self
end

--[=[
	@param value T
	@return Option<T>

	Creates an Option instance with the given value. Throws an error
	if the given value is `nil`.
]=]
function Option.Some(value)
	assert(value ~= nil, "Option.Some() value cannot be nil")
	return Option._new(value)
end

--[=[
	@param value T
	@return Option<T> | Option<None>

	Safely wraps the given value as an option. If the
	value is `nil`, returns `Option.None`, otherwise
	returns `Option.Some(value)`.
]=]
function Option.Wrap(value)
	if value == nil then
		return Option.None
	else
		return Option.Some(value)
	end
end

--[=[
	@param obj any
	@return boolean
	Returns `true` if `obj` is an Option.
]=]
function Option.Is(obj)
	return type(obj) == "table" and getmetatable(obj) == Option
end

--[=[
	@param obj any
	Throws an error if `obj` is not an Option.
]=]
function Option.Assert(obj)
	assert(Option.Is(obj), "Result was not of type Option")
end

--[=[
	@param data table
	@return Option
	Deserializes the data into an Option. This data should have come from
	the `option:Serialize()` method.
]=]
function Option.Deserialize(data) -- type data = {ClassName: string, Value: any}
	assert(type(data) == "table" and data.ClassName == CLASSNAME, "Invalid data for deserializing Option")
	return data.Value == nil and Option.None or Option.Some(data.Value)
end

--[=[
	@return table
	Returns a serialized version of the option.
]=]
function Option:Serialize()
	return {
		ClassName = self.ClassName,
		Value = self._v,
	}
end

--[=[
	@param matches {Some: (value: any) -> any, None: () -> any}
	@return any

	Matches against the option.

	```lua
	local opt = Option.Some(32)
	opt:Match {
		Some = function(num) print("Number", num) end,
		None = function() print("No value") end,
	}
	```
]=]
function Option:Match(matches)
	local onSome = matches.Some
	local onNone = matches.None
	assert(type(onSome) == "function", "Missing 'Some' match")
	assert(type(onNone) == "function", "Missing 'None' match")
	if self:IsSome() then
		return onSome(self:Unwrap())
	else
		return onNone()
	end
end

--[=[
	@return boolean
	Returns `true` if the option has a value.
]=]
function Option:IsSome()
	return self._s
end

--[=[
	@return boolean
	Returns `true` if the option is None.
]=]
function Option:IsNone()
	return not self._s
end

--[=[
	@param msg string
	@return value: any
	Unwraps the value in the option, otherwise throws an error with `msg` as the error message.
	```lua
	local opt = Option.Some(10)
	print(opt:Expect("No number")) -> 10
	print(Option.None:Expect("No number")) -- Throws an error "No number"
	```
]=]
function Option:Expect(msg)
	assert(self:IsSome(), msg)
	return self._v
end

--[=[
	@param msg string
	Throws an error with `msg` as the error message if the value is _not_ None.
]=]
function Option:ExpectNone(msg)
	assert(self:IsNone(), msg)
end

--[=[
	@return value: any
	Returns the value in the option, or throws an error if the option is None.
]=]
function Option:Unwrap()
	return self:Expect("Cannot unwrap option of None type")
end

--[=[
	@param default any
	@return value: any
	If the option holds a value, returns the value. Otherwise, returns `default`.
]=]
function Option:UnwrapOr(default)
	if self:IsSome() then
		return self:Unwrap()
	else
		return default
	end
end

--[=[
	@param defaultFn () -> any
	@return value: any
	If the option holds a value, returns the value. Otherwise, returns the
	result of the `defaultFn` function.
]=]
function Option:UnwrapOrElse(defaultFn)
	if self:IsSome() then
		return self:Unwrap()
	else
		return defaultFn()
	end
end

--[=[
	@param optionB Option
	@return Option
	Returns `optionB` if the calling option has a value,
	otherwise returns None.

	```lua
	local optionA = Option.Some(32)
	local optionB = Option.Some(64)
	local opt = optionA:And(optionB)
	-- opt == optionB

	local optionA = Option.None
	local optionB = Option.Some(64)
	local opt = optionA:And(optionB)
	-- opt == Option.None
	```
]=]
function Option:And(optionB)
	if self:IsSome() then
		return optionB
	else
		return Option.None
	end
end

--[=[
	@param andThenFn (value: any) -> Option
	@return value: Option
	If the option holds a value, then the `andThenFn`
	function is called with the held value of the option,
	and then the resultant Option returned by the `andThenFn`
	is returned. Otherwise, None is returned.

	```lua
	local optA = Option.Some(32)
	local optB = optA:AndThen(function(num)
		return Option.Some(num * 2)
	end)
	print(optB:Expect("Expected number")) --> 64
	```
]=]
function Option:AndThen(andThenFn)
	if self:IsSome() then
		local result = andThenFn(self:Unwrap())
		Option.Assert(result)
		return result
	else
		return Option.None
	end
end

--[=[
	@param optionB Option
	@return Option
	If caller has a value, returns itself. Otherwise, returns `optionB`.
]=]
function Option:Or(optionB)
	if self:IsSome() then
		return self
	else
		return optionB
	end
end

--[=[
	@param orElseFn () -> Option
	@return Option
	If caller has a value, returns itself. Otherwise, returns the
	option generated by the `orElseFn` function.
]=]
function Option:OrElse(orElseFn)
	if self:IsSome() then
		return self
	else
		local result = orElseFn()
		Option.Assert(result)
		return result
	end
end

--[=[
	@param optionB Option
	@return Option
	If both `self` and `optionB` have values _or_ both don't have a value,
	then this returns None. Otherwise, it returns the option that does have
	a value.
]=]
function Option:XOr(optionB)
	local someOptA = self:IsSome()
	local someOptB = optionB:IsSome()
	if someOptA == someOptB then
		return Option.None
	elseif someOptA then
		return self
	else
		return optionB
	end
end

--[=[
	@param predicate (value: any) -> boolean
	@return Option
	Returns `self` if this option has a value and the predicate returns `true.
	Otherwise, returns None.
]=]
function Option:Filter(predicate)
	if self:IsNone() or not predicate(self._v) then
		return Option.None
	else
		return self
	end
end

--[=[
	@param value any
	@return boolean
	Returns `true` if this option contains `value`.
]=]
function Option:Contains(value)
	return self:IsSome() and self._v == value
end

--[=[
	@return string
	Metamethod to transform the option into a string.
	```lua
	local optA = Option.Some(64)
	local optB = Option.None
	print(optA) --> Option<number>
	print(optB) --> Option<None>
	```
]=]
function Option:__tostring()
	if self:IsSome() then
		return ("Option<" .. typeof(self._v) .. ">")
	else
		return "Option<None>"
	end
end

--[=[
	@return boolean
	@param opt Option
	Metamethod to check equality between two options. Returns `true` if both
	options hold the same value _or_ both options are None.
	```lua
	local o1 = Option.Some(32)
	local o2 = Option.Some(32)
	local o3 = Option.Some(64)
	local o4 = Option.None
	local o5 = Option.None

	print(o1 == o2) --> true
	print(o1 == o3) --> false
	print(o1 == o4) --> false
	print(o4 == o5) --> true
	```
]=]
function Option:__eq(opt)
	if Option.Is(opt) then
		if self:IsSome() and opt:IsSome() then
			return (self:Unwrap() == opt:Unwrap())
		elseif self:IsNone() and opt:IsNone() then
			return true
		end
	end
	return false
end

--[=[
	@prop None Option<None>
	@within Option
	Represents no value.
]=]
Option.None = Option._new()

return (Option :: any) :: {
	Some: <T>(value: T) -> Option<T>,
	Wrap: <T>(value: T) -> Option<T>,

	Is: (obj: any) -> boolean,

	None: Option<any>,
}

]==]

 

local u1 = {};
u1.__index = u1;

function u1._new(p2) -- Line: 129
    -- upvalues: u1 (copy)
    return setmetatable({
        ClassName = "Option",
        _v = p2,
        _s = p2 ~= nil
    }, u1);
end;

function u1.Some(p3) -- Line: 145
    -- upvalues: u1 (copy)
    assert(p3 ~= nil, "Option.Some() value cannot be nil");

    return u1._new(p3);
end;

function u1.Wrap(p4) -- Line: 158
    -- upvalues: u1 (copy)
    if p4 == nil then
        return u1.None;
    end;

    return u1.Some(p4);
end;

function u1.Is(p5) -- Line: 171
    -- upvalues: u1 (copy)
    local v6;

    if type(p5) == "table" then
        v6 = getmetatable(p5) == u1;
    else
        v6 = false;
    end;

    return v6;
end;

function u1.Assert(p7) -- Line: 179
    -- upvalues: u1 (copy)
    local v8 = u1.Is(p7);
    assert(v8, "Result was not of type Option");
end;

function u1.Deserialize(p9) -- Line: 189
    -- upvalues: u1 (copy)
    local v10;

    if type(p9) == "table" then
        v10 = p9.ClassName == "Option";
    else
        v10 = false;
    end;

    assert(v10, "Invalid data for deserializing Option");

    return p9.Value == nil and u1.None or u1.Some(p9.Value);
end;

function u1.Serialize(p11) -- Line: 198
    return {
        ClassName = p11.ClassName,
        Value = p11._v
    };
end;

function u1.Match(p12, p13) -- Line: 219
    local Some = p13.Some;
    local None = p13.None;
    local v14 = type(Some) == "function";
    assert(v14, "Missing \'Some\' match");
    local v15 = type(None) == "function";
    assert(v15, "Missing \'None\' match");

    if p12:IsSome() then
        return Some(p12:Unwrap());
    end;

    return None();
end;

function u1.IsSome(p16) -- Line: 235
    return p16._s;
end;

function u1.IsNone(p17) -- Line: 243
    return not p17._s;
end;

function u1.Expect(p18, p19) -- Line: 257
    local v20 = p18:IsSome();
    assert(v20, p19);

    return p18._v;
end;

function u1.ExpectNone(p21, p22) -- Line: 266
    local v23 = p21:IsNone();
    assert(v23, p22);
end;

function u1.Unwrap(p24) -- Line: 274
    return p24:Expect("Cannot unwrap option of None type");
end;

function u1.UnwrapOr(p25, p26) -- Line: 283
    if p25:IsSome() then
        return p25:Unwrap();
    end;

    return p26;
end;

function u1.UnwrapOrElse(p27, p28) -- Line: 297
    if p27:IsSome() then
        return p27:Unwrap();
    end;

    return p28();
end;

function u1.And(p29, p30) -- Line: 323
    -- upvalues: u1 (copy)
    if p29:IsSome() then
        return p30;
    end;

    return u1.None;
end;

function u1.AndThen(p31, p32) -- Line: 347
    -- upvalues: u1 (copy)
    if not p31:IsSome() then
        return u1.None;
    end;

    local v33 = p32(p31:Unwrap());
    u1.Assert(v33);

    return v33;
end;

function u1.Or(p34, p35) -- Line: 362
    if p34:IsSome() then
        return p34;
    end;

    return p35;
end;

function u1.OrElse(p36, p37) -- Line: 376
    -- upvalues: u1 (copy)
    if p36:IsSome() then
        return p36;
    end;

    local v38 = p37();
    u1.Assert(v38);

    return v38;
end;

function u1.XOr(p39, p40) -- Line: 393
    -- upvalues: u1 (copy)
    local v41 = p39:IsSome();

    if v41 == p40:IsSome() then
        return u1.None;
    end;

    if v41 then
        return p39;
    end;

    return p40;
end;

function u1.Filter(p42, p43) -- Line: 411
    -- upvalues: u1 (copy)
    if p42:IsNone() or not p43(p42._v) then
        return u1.None;
    end;

    return p42;
end;

function u1.Contains(p44, p45) -- Line: 424
    local v46 = p44:IsSome() and p44._v == p45;

    return v46;
end;

function u1.__tostring(p47) -- Line: 438
    return not p47:IsSome() and "Option<None>" or "Option<" .. typeof(p47._v) .. ">";
end;

function u1.__eq(p48, p49) -- Line: 464
    -- upvalues: u1 (copy)
    if u1.Is(p49) then
        if p48:IsSome() and p49:IsSome() then
            return p48:Unwrap() == p49:Unwrap();
        end;

        if p48:IsNone() and p49:IsNone() then
            return true;
        end;
    end;

    return false;
end;

u1.None = u1._new();

return u1;