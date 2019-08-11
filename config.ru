require_relative './config/env'


use Rack::MethodOverride
use TrainerConteoller
use PokemonController
run ApplicationController