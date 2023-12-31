﻿using GestArm.Domain.Warehouses;
using GestArm.Domain.Categories;
using GestArm.Domain.Orders;
using GestArm.Domain.Families;
using GestArm.Domain.Products;
using GestArm.Domain.Users;
using GestArm.Domain.Shared;
using GestArm.Infrastructure;
using GestArm.Infrastructure.Warehouses;
using GestArm.Infrastructure.Categories;
using GestArm.Infrastructure.Orders;
using GestArm.Infrastructure.Families;
using GestArm.Infrastructure.Products;
using GestArm.Infrastructure.Shared;
using GestArm.Infrastructure.Users;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace GestArm;

public class Startup
{
    static string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddDbContext<GestArmDbContext>(opt =>
            opt.UseMySql(Configuration.GetConnectionString("Default"),
                    new MySqlServerVersion(new Version(10, 4, 17)))
                .ReplaceService<IValueConverterSelector, StronglyEntityIdValueConverterSelector>()
        );
        ConfigureMyServices(services);

        services.AddControllers().AddNewtonsoftJson();
        services.AddCors(options =>
        {
            //allows all origins and headers and methods for all endpoints in the application
            options.AddPolicy(name: MyAllowSpecificOrigins,
                builder =>
                {
                    builder.WithOrigins("http://localhost:4200")
                        //.AllowAnyOrigin()
                        .AllowAnyHeader()
                        .AllowCredentials()
                        .AllowAnyMethod();
                        //.AllowCredentials();
                });
        });
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
           if (env.IsDevelopment())
              app.UseDeveloperExceptionPage();
          else
              // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
              app.UseHsts();
   
/*         app.UseHttpsRedirection();
 */
        app.UseRouting();
        app.UseCors(MyAllowSpecificOrigins);

        app.UseAuthorization();

        app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
    }

    public void ConfigureMyServices(IServiceCollection services)
    {
        services.AddTransient<IUnitOfWork, UnitOfWork>();

        services.AddTransient<ICategoryRepository, CategoryRepository>();
        services.AddTransient<CategoryService>();

        services.AddTransient<IProductRepository, ProductRepository>();
        services.AddTransient<ProductService>();

        services.AddTransient<IFamilyRepository, FamilyRepository>();
        services.AddTransient<FamilyService>();

        services.AddTransient<IWarehouseRepository, WarehouseRepository>();
        services.AddTransient<IWarehouseService, WarehouseService>();

        services.AddTransient<IOrdersRepository, OrdersRepository>();
        services.AddTransient<IOrdersService, OrdersService>();

        services.AddTransient<IUserRepository, UserRepository>();
        services.AddTransient<IUserService, UserService>();

        services.AddTransient<IVerifyTokenRepository, VerifyTokenRepository>();
        services.AddTransient<IVerifyTokenService, VerifyTokenService>();
    }
}