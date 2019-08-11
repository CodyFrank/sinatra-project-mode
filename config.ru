require_relative './config/env'


use Rack::MethodOverride
use FighterController
use WeaponController
use SpellController
run ApplicationController