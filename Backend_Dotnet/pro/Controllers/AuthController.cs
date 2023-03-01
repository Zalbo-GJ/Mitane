using MongoDB.Driver;
using Microsoft.AspNetCore.Mvc;
using pro.models;
using pro.services;
using MongoDB.Bson;

namespace pro.Controller
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly AuthService _authService;


        public AuthController(AuthService authService)
        {
            _authService = authService;
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var allUsers = await _authService.GetUsers();
            if (allUsers == null)
            {
                return NotFound("sorry");

            }
            return Ok(allUsers);

        }
        [HttpGet("id")]
        public async Task<IActionResult> Get(string id)
        {
            var user = await _authService.GetUser(id);
            if (user == null)
            {
                return NotFound("sorry");

            }
            return Ok(user);

        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(User user)
        {

            user.id = ObjectId.GenerateNewId();
            await _authService.CreateUser(user);

            return CreatedAtAction(nameof(Get), routeValues: new { _id = user.id }, value: user.id.ToString());
        }
        [HttpPost("login")]
        public async Task<IActionResult> Login(SignIn user)
        {
            if (user is null)
            {
                throw new ArgumentNullException(nameof(user));
            }

            var found = await _authService.CheckUser(user.email);
            if (found == null)
            {
                return NotFound();
            }
            if (found.password == user.password)
            {
                return Ok(found.id.ToString());
            }
            else
            {
                return StatusCode(403);
            }


        }
    }
}
