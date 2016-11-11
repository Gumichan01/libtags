

CC=g++
FLAGS=-Wall -g -std=c++0x
HEADER_DIR=src/
SRC_DIR=src/
OBJ_DIR=src/
OBJS=$(OBJ_DIR)8859.o $(OBJ_DIR)flac.o $(OBJ_DIR)id3genres.o $(OBJ_DIR)id3v1.o \
$(OBJ_DIR)id3v2.o $(OBJ_DIR)m4a.o $(OBJ_DIR)tags.o $(OBJ_DIR)utf16.o \
$(OBJ_DIR)vorbis.o

MAIN_DIR=examples/
CODE_MAIN=$(MAIN_DIR)readtags.cpp
OBJ_MAIN=$(MAIN_DIR)readtags.o

LIBTAG_SRC=$(SRC_DIR)libtagspp.cpp
LIBTAG_OBJ=$(OBJ_DIR)libtagspp.o

EXE=rtags
LIB=libtagspp.a
DOXY_FILE=Doxyfile

all: $(LIB)

$(LIB): $(OBJS) $(LIBTAG_OBJ)
	ar rcs $@ $^


$(EXE): $(OBJ_MAIN) $(OBJS) $(LIBTAG_OBJ)
	@echo "exec"
	$(CC) $^ -o $@ $(FLAGS)

$(OBJ_MAIN): $(CODE_MAIN)
	@echo "libtag++ MAIN"
	$(CC) -c $< -o $@ -I $(SRC_DIR) $(FLAGS)
	@echo "libtag++ OK"


libtagspp.o: $(LIBTAG_OBJ)
	@echo "libtag++ OK"

$(LIBTAG_OBJ): $(LIBTAG_SRC) $(SRC_DIR)libtagspp.hpp
	@echo "libtag++ compile"
	$(CC) -c $< -o $@ -I $(SRC_DIR) $(FLAGS)

%.o: %.cpp
	$(CC) -c $< -o $@ $(FLAGS)

documentation : $(DOXY_FILE)
	@echo "Generating the doxygen file from "$<
	@doxygen $<

clean:
	rm -rf $(OBJ_DIR)*.o

clear:
	rm -rf $(OBJ_DIR)*.o $(EXE) $(OBJ_MAIN) $(LIB)
