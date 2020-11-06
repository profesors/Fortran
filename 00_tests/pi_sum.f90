program pi_sum

    integer, parameter:: limit = 1000
    integer:: i
    real:: pi[*]

    do i = this_image(), limit, num_images()
        pi = pi + (-1)**(i+1) / real( 2*i-1)
    end do
    sync all

    ! global barrier
    if (this_image() == 1) then
        do i = 2, num_images()
            pi = pi+pi[i]
        end do
        pi = pi*4.0
        print *, "Result", pi
    end if

end program pi_sum
