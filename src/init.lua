if not game then script = require("./RelativeString") end

-- metatablecatgames 2024 - Licensed under the MIT License
--local RunService = game:GetService("RunService")
local Common = require(script.Common)
local Service = require(script.Service)
local Native = require(script.Native)
local Types = require(script.Types)
local Metakeys = require(script.Metakeys)

local REFLECTION = require(script.Reflection)
local ERROR = require(script.Error)

local Catwork
export type Object<Parameters> = Types.Object<Parameters>
export type Class<A> = Types.Class<A>
export type Service = Types.Service

Catwork = setmetatable({
	__VERSION = Common.Version,
	Plugin = if game then script:FindFirstAncestorOfClass("Plugin") else nil,
	meta = Metakeys.export,

	-- Constructors
	new = function<A>(params: A): Types.Object<A>
		REFLECTION.ARG(1, "Catwork.new", REFLECTION.TABLE, params)

		return Native.Object(params)
	end,
	
	Service = function(params: Types.ServiceCtorParams): Types.Service
		REFLECTION.ARG(1, "Catwork.Service", REFLECTION.TABLE, params)

		return Service(params)
	end,

	Class = function<A>(name: string, createFn: (Types.Object<A>) -> ()): <B>(B) -> Types.Object<A & B>
		return Native.GetClassLike(name, createFn)
	end,

	-- Deprecated
	Fragment = function(params)
		ERROR.FRAGMENT_DEPRECATED_MIGRATION()
	end,

	--[[
	EnableAnalysis = function(self: Catwork)
		if RunService:IsRunning() then ERROR.ANALYSIS_MODE_NOT_AVAILABLE("Run Mode") end
		if self.Plugin then ERROR.ANALYSIS_MODE_NOT_AVAILABLE("Plugin") end
	end
	]]--
},{
	__tostring = function(self) return `Module(Catwork v{self.__VERSION})` end
})

table.freeze(Catwork)
type Catwork = typeof(Catwork)
if not Catwork.Plugin then print(Common.WelcomeMessage) end
return Catwork