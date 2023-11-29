require "test_helper"

class JuegosControllerTest < ActionDispatch::IntegrationTest

  test 'renderizar la lista de juegos' do
    get juegos_path 

    assert_response :success
    assert_select '.juego', 2
  end

  test 'renderizar una pagina detallada de un juego' do
    get juego_url(juegos(:one))

    assert_response :success
    assert_select '.nombre', 'Monopoly'
    assert_select '.tipo', 'Juego de Negocios'
    assert_select '.estado', 'Nuevo'
    assert_select '.cant_jugadores', 4
    assert_select '.descripcion', 'Monopoliza al mercado'
    assert_select '.imagen', 'imagen'

  end


  test 'renderizar un nuevo formulario de juego' do
    get new_juego_path

    assert_response :success
    assert_select 'form'
  end

  test 'permitir crear un nuevo juego' do
    post juegos_path, params: {
      juego: {
        nombre: 'Monopoly',
        tipo: 'Juego de Negocios',
        estado: 'Nuevo',
        cant_jugadores: 4,
        descripcion: 'Monopoliza al mercado',
        imagen: 'imagen'
      }
    }
    assert_redirected_to juegos_path
    assert_equal flash[:notice], 'Tu juego se ha creado correctamente'
  end

  test 'No permitir crear un juego con campos obligatorios vacios' do
    post juegos_path, params: {
      juego: {
        nombre: '',
        tipo: 'Juego de Negocios',
        estado: 'Nuevo',
        cant_jugadores: 4,
        descripcion: 'Monopoliza al mercado',
        imagen: 'imagen'
      }
    }
    assert_response :unprocessable_entity
  end

  test 'renderizar un formulario de edicion de juego' do
    get edit_juego_path(juegos(:one))

    assert_response :success
    assert_select 'form'
  end

  test 'permitir actualizar un juego' do
    patch juego_path(juegos(:one)), params: {
      juego: {
        nombre: 'Monopoly Mundial',
      }
    }
    assert_redirected_to juegos_path
    assert_equal flash[:notice], 'Tu juego se ha actualizado correctamente'
  end

  test 'no permitir actualizar un juego con un campo vacio' do
    patch juego_path(juegos(:one)), params: {
      juego: {
        nombre: nil
      }
    }
    assert_response :unprocessable_entity
  end

  test 'permitir borrar juegos' do
    assert_difference('Juego.count', -1) do
      delete juego_path(juegos(:one))
    end

    assert_redirected_to juegos_path
    assert_equal flash[:notice], 'Tu juego se ha eliminado correctamente'
  end
end
