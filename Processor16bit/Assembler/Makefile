CC := g++
SRC_DIR := ./src
BLD_DIR := ./build
BIN_DIR := ./bin
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(BLD_DIR)/%.o,$(SRC_FILES))
LDFLAGS := $() #`pkg-config --cflags --libs sdl2`
CPPFLAGS := $()
CXXFLAGS := $()

all: baej

baej: $(OBJ_FILES)
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$@ $^

$(BLD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -rf $(BLD_DIR)/*
