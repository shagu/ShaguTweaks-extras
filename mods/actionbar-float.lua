local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Floating Actionbar"],
  description = T["Removes all background textures and lets the actionbar float."],
  expansions = { ["vanilla"] = true, ["tbc"] = false },
  maintainer = "@shagu (GitHub)",
  category = T["Action Bar"],
  enabled = nil,
})

local texture_removals = {
  MainMenuXPBarTexture0, MainMenuXPBarTexture1, MainMenuXPBarTexture2, MainMenuXPBarTexture3,
  ReputationXPBarTexture0, ReputationXPBarTexture1, ReputationXPBarTexture2, ReputationXPBarTexture3,
  ReputationWatchBarTexture0, ReputationWatchBarTexture1, ReputationWatchBarTexture2, ReputationWatchBarTexture3,
  MainMenuBarTexture0, MainMenuBarTexture1, MainMenuBarTexture2, MainMenuBarTexture3,
  BonusActionBarTexture1, BonusActionBarTexture0, BonusActionBarTexture2
}

local actionbars = {
  "Action", "BonusAction", "MultiBarBottomLeft", "MultiBarBottomRight",
  "MultiBarLeft", "MultiBarRight", "Shapeshift"
}

module.enable = function(self)
  MainMenuBar:ClearAllPoints()
  MainMenuBar:SetPoint("BOTTOM", 0, 8)

  -- align actionbutton textures and add border
  for _, prefix in pairs(actionbars) do
    for i = 1, NUM_ACTIONBAR_BUTTONS do
      local button = _G[prefix .. "Button" .. i]
      local texture = _G[prefix.."Button"..i.."NormalTexture"]

      if button and texture then
        texture:SetWidth(60)
        texture:SetHeight(60)
        texture:SetPoint("CENTER", 0, 0)
        ShaguTweaks.AddBorder(button, 3, { r=.7, g=.7, b=.7, a=1 })
      end
    end
  end

  ShaguTweaks.AddBorder(MainMenuBarPerformanceBarFrameButton, { -12, -0.5, -8, 4.5 }, { r=.7, g=.7, b=.7, a=1 })

  -- replace reputation bar texture
  ReputationWatchStatusBar:SetStatusBarTexture("Interface\\AddOns\\ShaguTweaks-extras\\img\\xpbar")
  ReputationWatchStatusBarBackground:SetTexture("Interface\\AddOns\\ShaguTweaks-extras\\img\\xpbar")
  ReputationWatchStatusBarBackground:SetVertexColor(0, 0, 0, .5)

  -- replace experience bar texture
  MainMenuExpBar:SetStatusBarTexture("Interface\\AddOns\\ShaguTweaks-extras\\img\\xpbar")
  local _, _, _, _, _, background = MainMenuExpBar:GetRegions()
  background:SetTexture("Interface\\AddOns\\ShaguTweaks-extras\\img\\xpbar")
  background:SetVertexColor(0, 0, 0, .5)

  -- update reputation bar position
  local HookReputationWatchBar_Update = ReputationWatchBar_Update
  ReputationWatchBar_Update = function(newLevel)
    HookReputationWatchBar_Update(newLevel)
    if MainMenuExpBar:IsShown() then
      ReputationWatchBar:SetPoint("BOTTOM", MainMenuBar, "TOP", 0, -7)
    else
      ReputationWatchBar:SetPoint("TOP", MainMenuBar, "TOP", 0, 2)
    end
  end

  -- hide max level top frame
  MainMenuBarMaxLevelBar:SetAlpha(0)

  -- remove textures
  for _, texture in pairs(texture_removals) do
    if texture then
      texture:SetTexture()
      texture:Hide()
    end
  end
end
