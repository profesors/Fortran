FC = gfortran
CAF = caf
SRC = $(wildcard src/*.f90)
FILES_NO_EXT = $(notdir $(SRC))
TARGETS = $(addprefix app/,$(FILES_NO_EXT:.f90=))

# Modules
MOD_SRC = $(wildcard src/mod/*.f)
MOD_TARGETS = $(addprefix app/mod/,$(notdir $(MOD_SRC:.f=.mod)))

# Arguments
#ARGS = -Wall -Wextra -std=f2018 -O3 -pedantic -fdec-math -ffree-form -Imod
ARGS = -std=f2018 -ffree-form -Imod


all: app mod $(TARGETS)

# Make target directory
app mod:
	@mkdir -p app
	@mkdir -p mod

app/integral_01_coarray: src/integral_01_coarray.f90
	ifort $< -coarray -o $@
	#export FOR_COARRAY_NUM_IMAGES=8
	#time ./app/integral_01_coarray

# Caso genérico
app/%: src/%.f90 
	$(FC) $(ARGS) $< -o $@


clean:
	@rm -f $(TARGETS)
	@rm -f mod/*.mod mod/*.o
