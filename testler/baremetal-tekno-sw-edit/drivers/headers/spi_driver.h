
typedef union
{
	struct {
		unsigned int spi_en  : 1;
		unsigned int spi_rst : 1;
		unsigned int cpha    : 1;
		unsigned int cpol    : 1;
		unsigned int null    : 12;
		unsigned int sck_div : 16;
	} fields;
	uint32_t bits;
}spi_ctrl;

typedef union
{
	struct {
		unsigned int mosi_full  : 1;
		unsigned int miso_full  : 1;
		unsigned int mosi_empty : 1;
		unsigned int miso_empty	: 1;
		unsigned int null	: 28;
	} fields;
	uint32_t bits;
}spi_status;

typedef union
{
	struct {
		unsigned int length    : 9;
		unsigned int cs_active : 1;
		unsigned int null1     : 2;
        	unsigned int direction : 2;
        	unsigned int null2     : 18;
	} fields;
	uint32_t bits;
}spi_cmd;
/// Functions ///

int spi_miso_empty();
