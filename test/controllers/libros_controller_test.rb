require "test_helper"

class LibrosControllerTest < ActionDispatch::IntegrationTest

  test 'renderizar la lista de libros' do
    get libros_path 

    assert_response :success
    assert_select '.libro', 2
  end

  test 'render una pagina detallada de un libro' do
    get libro_path(libros(:one))

    assert_response :success
    assert_select '.titulo', 'Las cronicas de Narnia'
    assert_select '.autor', 'C. S. Lewis'
    assert_select '.descripcion', 'Aventura Epica'
  end


  test 'render a new libro form' do
    get new_libro_path

    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new libro' do
    post libros_path, params: {
      libro: {
        titulo: 'Harry Potter',
        autor: 'J. K. Rowling',
        descripcion: 'Una Aventura de Magia'
      }
    }
    assert_redirected_to libros_path
    assert_equal flash[:notice], 'Tu libro se ha creado correctamente'
  end

  test 'does not allow to create a new libro with empty fields' do
    post libros_path, params: {
      libro: {
        titulo: '',
        autor: 'J. K. Rowling',
        descripcion: 'Una Aventura de Magia'
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render a edit libro form' do
    get edit_libro_path(libros(:one))

    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a libro' do
    patch libro_path(libros(:one)), params: {
      libro: {
        titulo: 'Harry Potter y la Piedra Filosofal',
      }
    }
    assert_redirected_to libros_path
    assert_equal flash[:notice], 'Tu libro se ha actualizado correctamente'
  end

  test 'does not allow to update a libro with a invalid field' do
    patch libro_path(libros(:one)), params: {
      libro: {
        titulo: nil
      }
    }
    assert_response :unprocessable_entity
  end

  test 'can delete libros' do
    assert_difference('Libro.count', -1) do
      delete libro_path(libros(:one))
    end

    assert_redirected_to libros_path
    assert_equal flash[:notice], 'Tu libro se ha eliminado correctamente'
  end

end
