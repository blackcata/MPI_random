F90=ifort
FCFLAGS=-O3 -I$(MPI_HOME)/include
LDFLAGS=-L$(MPI_HOME)/lib -lmpichf90 -lmpich -lpthread -lmpl

TARGET= MPI_RAND.exe
OBJECT= mpi_module.o mpi_random.o

all : $(TARGET)
$(TARGET) : $(OBJECT)
	$(F90) -o $@ $^ $(LDFLAGS)

.SUFFIXES. : .o .f90

%.o : %.f90
	$(F90) $(FCFLAGS) -c $<

clean :
	rm MPI_RAND.exe
	rm mpi_random.mod
	rm -f *.o
	rm RESULT/*.plt
