 
ESX = exports["es_extended"]:getSharedObject()  
local ox_inventory = exports.ox_inventory
local insidee = nil


local ped = PlayerPedId()


local options = {
  {
      name = 'mechanic',
      event = 'mechanic_menu',
      icon = 'fa-solid fa-wrench',
      label = 'Mechanické menu',
      groups = {["lsc"] = 0,["bennys"] = 0,["underground"] = 0,["libertywalk"] = 0}
      distance = 1,
  } 
}

local optionNames = {'mechanic'}

exports.ox_target:addGlobalVehicle(options)

RegisterNetEvent('mechanic_menu', function()
  lib.registerContext({
    id = 'mechanic_menulib',
    title = 'Mechanické menu', 
    options = {
      {
        title = 'Opravit vozidlo',
        description = 'K opravě potřebujete 1x opravnou sadu', 
        onSelect =  repaircar,
      },
      {
        title = 'Opláchnout vozidlo',
        description = 'Potřebujete 1x mycí prostředek a houbu', 
        onSelect =  washing,
      },
      {
        title = 'Odemknout vozidlo',
        description = 'Potřebujete 1x klíč', 
        onSelect =  unlockcar,
      }, 
      {
        title = 'Odtáhnout vozidlo',
        description = 'Odtáhnout', 
        onSelect =  delcar,
      },
    }
  })

  lib.showContext('mechanic_menulib')
 
end)
function unlockcar()
  lib.hideContext()
  
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local weldingtorch = ox_inventory:Search('count', 'welding_torch') 

   
  if IsPedSittingInAnyVehicle(playerPed) then
    lib.notify({
      title = 'Ve vozidle se někdo nachází', 
      type = 'error'
  })
     return
  end

  if  weldingtorch >= 1  and DoesEntityExist(vehicle)  then 
    lib.callback('hackcar:remove', false, function(Player)end)
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

      if lib.progressBar({
        duration = 10000,
        label = 'Odemykání',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
       
    }) then    
      SetVehicleDoorsLocked(vehicle, 1)
      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
      ClearPedTasksImmediately(playerPed)

      else   
 
      end

  
 
  end 
  else
    lib.notify({
      title = 'Potřebujete k tomu 1x klíč nebo jste daleko od vozidla', 
      type = 'error'
  })    
end
end
function repaircar()
  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local repairkit = ox_inventory:Search('count', 'repair_kit') 
  if  repairkit >= 1  and DoesEntityExist(vehicle)  then 
    FreezeEntityPosition(vehicle, true) 
 
     lib.callback('repairkit:remove', false, function(Player)end)
    if DoesEntityExist(vehicle) then
      if lib.progressBar({
        duration = 10000,
        label = 'Opravuji vozidlo',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = true,
        },
        anim = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            clip = 'machinic_loop_mechandplayer'
        },
    }) then    
      SetVehicleFixed(vehicle)
      FreezeEntityPosition(vehicle, false)
      else   
 
      end
    end 
  else
    lib.notify({
      title = 'Potřebujete 1x opravnou sadu nebo jste daleko od vozidla', 
      type = 'error'
  })   
  end
end


function washing()

  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local washtool = ox_inventory:Search('count', 'wash_tool') 
  
  local sponge = ox_inventory:Search('count', 'sponge') 
  if  washtool >= 1  and sponge >= 1 and DoesEntityExist(vehicle)  then 
    FreezeEntityPosition(vehicle, true) 

    lib.callback('washing:remove', false, function(Player)end)
    if DoesEntityExist(vehicle) then
      if lib.progressBar({
        duration = 5000,
        label = 'Umývám vozidlo',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'gestures@f@standing@casual',
            clip = 'gesture_point'
        },
        prop = {
            model = `v_serv_bs_spray`,
            bone = 4170,
            pos = vec3(0.00, -0.02, -0.10),
            rot = vec3(1.50, -1.20, -1.00)
        },
    }) then   
       washtwo()
      else   
 
      end
    end 
  else
    lib.notify({
      title = 'Potřebujete čístící prostředky nebo jste daleko od vozidla', 
      type = 'error'
  })   
  end

end

function washtwo()

  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
if lib.progressBar({
  duration = 5000,
  label = 'Čištím',
  useWhileDead = false,
  canCancel = false,
  disable = {
      car = true,
      move = true,
      combat = true,
      mouse = false,
  },
  anim = {
      dict = 'timetable@floyd@clean_kitchen@base',
      clip = 'base'
  },
  prop = {
      model = `prop_sponge_01`,
      bone = 28422,
      pos = vec3(0.0, 0.0, -0.01),
      rot = vec3(90.0, 0.0, 0.0)
  },
}) then    
SetVehicleDirtLevel(vehicle, 0)
FreezeEntityPosition(vehicle, false)
else   

end

end
 


function delcar()

  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
 
  if IsPedSittingInAnyVehicle(playerPed) then
    lib.notify({
      title = 'Uvnitř jsou hráči', 
      type = 'error'
  })
     return
  end
  if    DoesEntityExist(vehicle)  then 
  
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

      if lib.progressBar({
        duration = 10000,
        label = 'Odtahuji',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        }, 
       
    }) then     
      ESX.Game.DeleteVehicle(vehicle)
      ClearPedTasksImmediately(playerPed)
      else   
 
      end
  end 
  else
    lib.notify({
      title = 'Příliš daleko od vozidla', 
      type = 'error'
  })    
end
 end