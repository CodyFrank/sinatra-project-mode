require_relative './config/env'


use Rack::MethodOverride
use TrainerController
use PokemonController
run ApplicationController