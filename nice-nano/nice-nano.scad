BODY_WIDTH = 18;
BODY_LENGTH = 33.1;
BODY_HEIGHT = 1.5;

USB_WIDTH = 8.8;
USB_HEIGHT = 3.1;
USB_LENGTH = 6.4;
USB_CORNER_RADIUS = 0.7;
USB_CORNER_OFFSET_X = USB_WIDTH / 2 - USB_CORNER_RADIUS;
USB_CORNER_OFFSET_Y = USB_HEIGHT / 2 - USB_CORNER_RADIUS;

PIN_EDGE_GAP_Y = 0.8;
PIN_EDGE_GAP_X = 0.8;
PIN_RADIUS = 0.8;
PIN_POSITION_X = (BODY_WIDTH - PIN_RADIUS * 2 - PIN_EDGE_GAP_X) / 2; // Distance between the centre-line of the board and the centre of each pair of pins
PIN_POSITION_Y = 2.54;

// TODO: USB-C port using intersection of 4 cylinders for the corners and 2 cuboids for the port body.
translate([BODY_WIDTH / 2, BODY_LENGTH / 2, BODY_HEIGHT / 2]) {

    union(){
    // subtract the volume of the pin holes from the volume of the board body
    difference() {
        cube([BODY_WIDTH, BODY_LENGTH, BODY_HEIGHT], center = true);

        // Iterate over each pair of pins' position along the length of the board
        for (i = [0 : PIN_POSITION_Y : PIN_POSITION_Y * 12]) {
            pinPositionY = -BODY_LENGTH / 2 + PIN_EDGE_GAP_Y + PIN_RADIUS / 2 + i; // Position of each pair of pins along the length of the board

            translate([PIN_POSITION_X, pinPositionY, 0]) {
                cylinder(h=BODY_HEIGHT + 0.1, r=PIN_RADIUS, center = true, $fn = 32);
            }

            translate([-PIN_POSITION_X, pinPositionY, 0]) {
                cylinder(h=BODY_HEIGHT + 0.1, r=PIN_RADIUS, center = true, $fn = 32);
            }

        }
    }

    // Iterate over each pair of pins' position along the length of the board and insert a pin model
    for (i = [0 : PIN_POSITION_Y : PIN_POSITION_Y * 12]) {
        pinPositionY = -BODY_LENGTH / 2 + PIN_EDGE_GAP_Y + PIN_RADIUS / 2 + i; // Position of each pair of pins along the length of the board

        translate([PIN_POSITION_X, pinPositionY, -BODY_HEIGHT / 2]) {
            cylinder(h=BODY_HEIGHT * 3, r=PIN_RADIUS/2, center = true, $fn = 32);
        }

        translate([-PIN_POSITION_X, pinPositionY, -BODY_HEIGHT / 2]) {
            cylinder(h=BODY_HEIGHT * 3, r=PIN_RADIUS/2, center = true, $fn = 32);
        }

    }

    union(){
    translate([0, BODY_LENGTH / 2 - USB_LENGTH / 2 * 0.6, BODY_HEIGHT / 2]) {
        cube([USB_WIDTH - USB_CORNER_RADIUS * 2, USB_LENGTH, USB_HEIGHT], center = true);
        cube([USB_WIDTH, USB_LENGTH, USB_HEIGHT - USB_CORNER_RADIUS * 2], center = true);
        
        rotate([90, 0, 0]) {
            translate([USB_CORNER_OFFSET_X, USB_CORNER_OFFSET_Y, 0]) {
                cylinder(h = USB_LENGTH, r = USB_CORNER_RADIUS, center = true, $fn = 32);
            }

            translate([-USB_CORNER_OFFSET_X, USB_CORNER_OFFSET_Y, 0]) {
                cylinder(h = USB_LENGTH, r = USB_CORNER_RADIUS, center = true, $fn = 32);
            }

            translate([-USB_CORNER_OFFSET_X, -USB_CORNER_OFFSET_Y, 0]) {
                cylinder(h = USB_LENGTH, r = USB_CORNER_RADIUS, center = true, $fn = 32);
            }

            translate([USB_CORNER_OFFSET_X, -USB_CORNER_OFFSET_Y, 0]) {
                cylinder(h = USB_LENGTH, r = USB_CORNER_RADIUS, center = true, $fn = 32);
            }

        }
    }
    }
    }
}

