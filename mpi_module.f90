
MODULE mpi_random
    IMPLICIT NONE

    INTEGER :: ierr, nx, ny, nz, nxl, nxr, nys, nyn, mpi_xsize, mpi_ysize
    REAL(KIND=8),ALLOCATABLE,DIMENSION(:,:,:) :: PT

    TYPE :: MYMPI
      INTEGER :: nprocs, myrank, nx_mpi, ny_mpi
      INTEGER :: mpisize_x, mpisize_y, mpirank_x, mpirank_y
      INTEGER,DIMENSION(0:3) :: rank_sur
    END TYPE MYMPI

    SAVE

  CONTAINS
    SUBROUTINE MPI_SETUP(mpi_xsize,mpi_ysize,mpi_info)

    IMPLICIT NONE
    INTEGER,INTENT(IN)        :: mpi_xsize, mpi_ysize
    TYPE(MYMPI),INTENT(INOUT) :: mpi_info

    mpi_info%mpisize_x = mpi_xsize
    mpi_info%mpisize_y = mpi_ysize
    mpi_info%nx_mpi    = Nx/mpi_xsize
    mpi_info%ny_mpi    = Ny/mpi_ysize
    mpi_info%mpirank_x = mpi_info%myrank/mpi_ysize
    mpi_info%mpirank_y = mod(mpi_info%myrank,mpi_ysize)

    IF (mpi_info%mpirank_x == 0) THEN
       mpi_info%rank_sur(0) = -1;
    ELSE
       mpi_info%rank_sur(0) = mpi_info%myrank - mpi_info%mpisize_y;
    END IF

    IF (mpi_info%mpirank_x == mpi_info%mpisize_x-1) THEN
        mpi_info%rank_sur(1) = -1;
    ELSE
      mpi_info%rank_sur(1) = mpi_info%myrank + mpi_info%mpisize_y;
    END IF

    IF (mpi_info%mpirank_y == 0) THEN
       mpi_info%rank_sur(2) = -1;
    ELSE
      mpi_info%rank_sur(2) = mpi_info%myrank - 1;
    END IF

    IF (mpi_info%mpirank_y == mpi_info%mpisize_y-1) THEN
      mpi_info%rank_sur(3) = -1;
    ELSE
      mpi_info%rank_sur(3) = mpi_info%myrank + 1;
    END IF

END SUBROUTINE

  END MODULE
