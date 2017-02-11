CSRCS=create_scene_graph.cpp \
      simple.cpp

CFLAGS =  -c -O3 -DNDEBUG -fPIC

INCLUDE = -I. -I/usr/include/ -I/usr/include/X11/ -I/usr/local/include/  
INCOSG = 
LDLIBS = -lm -ldl -lGL -lGLU -lpthread -lXext -lX11

LDFLAGS =  -L. -L/usr/lib -L/usr/X11R6/lib -L/usr/local/lib -L/usr/local/lib64
LDOSG =  -losg -losgViewer -losgSim -losgDB
COBJS=$(patsubst %.cpp,%.o,$(CSRCS))

CC = g++

EXE = my-exec

all: $(EXE)


$(EXE): $(COBJS) 
	$(CC) -o $(EXE) $(COBJS) $(INCLUDE) $(INCOSG) $(LDFLAGS) $(LDLIBS) $(LDOSG)


$(COBJS): %.o: %.cpp 
	$(CC) -c $(CFLAGS)  $< -o $@	 

.PHONY : clean
clean:
	rm $(COBJS) $(EXE)

