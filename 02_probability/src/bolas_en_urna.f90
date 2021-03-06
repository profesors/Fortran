module mod_bolas_en_urna
    integer, parameter:: n_urnas=3, n_bolas=5, casos_posibles=n_urnas**n_bolas
    integer:: n_bolas_en_urna(n_urnas)
    integer:: casos_favorables
end module mod_bolas_en_urna



program bolas_en_urna
    use mod_bolas_en_urna
    implicit none
    integer:: v(n_bolas), i
    character(len=100):: fmt_vector

    ! Setup ----------
    v = 1
    casos_favorables = 0
    write (fmt_vector, *) "(", n_bolas, "i3)"
    print *, "----------------------------------------------------------------"
    print *, "BOLA EN LA URNA     Nº BOLAS CADA URNA        CASO FAVORABLE"
    print *, " b1 b2 b3 b4 b5               U1 U2 U3"
    print *, "----------------------------------------------------------------"


    ! Main loop ----------
    call mostrar_fila_info()
    do i = 2, casos_posibles
        call next_iteration(v, n_bolas)
    end do

    print *, "----------------------------------------------------------------"
    print *, "Casos favorables: ", casos_favorables
    print *, "Casos posibles:   ", casos_posibles
    print "(a,f6.4)", " Probabilidad:           ", real(casos_favorables)/casos_posibles

contains

    recursive subroutine next_iteration(v, p)
        integer, intent(inout):: v(n_bolas)
        integer:: p

        if (v(p) /= n_urnas) then
            v(p) = v(p) + 1
            call mostrar_fila_info()
        else
            v(p) = 1
            call next_iteration(v, p-1)
        end if
    end subroutine next_iteration




    subroutine contar_bolas_en_urna()
        integer:: i

        n_bolas_en_urna = 0
        i_bola: do i = 1, n_bolas
            n_bolas_en_urna(v(i)) = n_bolas_en_urna(v(i)) + 1
        end do i_bola
    end subroutine




    subroutine mostrar_fila_info()
        ! Testea el caso buscado y cuenta las bolas en cada urna
        character(len=20):: fmt_vector
        call contar_bolas_en_urna()
        write (fmt_vector, *) "(a,", n_bolas, "i3)"
        write (*, fmt_vector, advance="no") " ", v
        write (*, "(a14, 3i3)", advance="no") "", n_bolas_en_urna
        call test_caso_buscado()
        !call sleep(1)
    end subroutine mostrar_fila_info


    subroutine test_caso_buscado()
        ! Resuelve el apartado E
        if ((n_bolas_en_urna(1) == 3 .or. n_bolas_en_urna(2) == 3 .or. n_bolas_en_urna(3) == 3) .and. &
            (n_bolas_en_urna(1) == 2 .or. n_bolas_en_urna(2) == 2 .or. n_bolas_en_urna(3) == 2)) then
            ! Caso favorable
            casos_favorables = casos_favorables + 1
            write (*, "(a, i4)") "           Sí nº", casos_favorables
        else
            ! Caso no favorable
            write (*, "(a)", advance="yes") ""
        end if
    end subroutine test_caso_buscado
end program
