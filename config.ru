require_relative './config/env'


use Rack::MethodOveride
use FighterController
use WeaponController
use SpellController
run ApplicationController