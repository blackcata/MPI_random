PROGRAM MPI_RAND
    USE mpi_random

    IMPLICIT NONE
    INCLUDE 'mpif.h'

    INTEGER :: i,j,k
    REAL(KIND=8) :: randomnumber
    TYPE(MYMPI) :: mpi_info

    mpi_xsize = 4
    mpi_ysize = 4

    nx = 64
    ny = 64
    nz = 64

    ALLOCATE( PT(1:Nz, 1:Ny, 1:Nx) )
    PT = 0.0

    CALL MPI_INIT(ierr)
    CALL MPI_COMM_RANK(MPI_COMM_WORLD,mpi_info%myrank,ierr)
    CALL MPI_SETUP(mpi_xsize,mpi_ysize,mpi_info)

    WRITE(*,*) 'MYRANK IS : ', mpi_info%mpirank_x,  mpi_info%mpirank_y, mpi_info%myrank

    nxl = mpi_info%mpirank_x*mpi_info%nx_mpi + 1
    nxr = nxl + mpi_info%nx_mpi - 1

    nys = mpi_info%mpirank_y*mpi_info%ny_mpi + 1
    nyn = nys + mpi_info%ny_mpi - 1
    CALL RANDOM_SEED()

    DO i = 1,nx
      DO j = 1,ny
        DO k = 1,nz

          CALL RANDOM_NUMBER(randomnumber)

        IF ( nxl <= i .AND. nxr >=i .AND. nys <=j .AND. nyn >=j ) THEN
          WRITE(*,*)  i,j,k, randomnumber
        END IF

        END DO
      END DO
    END DO

    CALL MPI_FINALIZE(ierr)

END PROGRAM MPI_RAND
