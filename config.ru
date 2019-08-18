require_relative './config/env'


use Rack::MethodOverride
use SessionsController
use TrainerController
use PokemonController
run ApplicationController